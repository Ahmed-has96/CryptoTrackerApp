import SwiftUI
import Charts

struct CryptoChartView: View {
    @StateObject private var viewModel = CryptoListViewModel()
    @State private var selectedIDs = Set<String>()
    @State private var showSelection = false
    @State private var emojiThreshold: String = "10"
    @State private var showEmojis = false // Styrer om animasjonen skal vises

    var body: some View {
        NavigationView {
            VStack {
                Text("Statistikk")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 10)

                // Felt for å angi verdi
                HStack {
                    Text("💰 Emoji-grense (%):")
                        .font(.headline)
                    Spacer()
                    TextField("0-100", text: $emojiThreshold)
                        .keyboardType(.numberPad)
                        .frame(width: 60)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(.center)
                        .onChange(of: emojiThreshold) { _ in checkForAnimation() }
                }
                .padding(.horizontal)

                // Knapp for valge kryptovaluta
                Button(action: { showSelection = true }) {
                    Text(selectedIDs.isEmpty ? "Velg kryptovaluta" : "Endre valg")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                }
                .padding(.horizontal)

                // Diagramseksjon
                if !selectedIDs.isEmpty {
                    Text("Markedsbevegelser (1h, 24h, 7d)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.top, 10)

                    Chart(chartData) { data in
                        BarMark(
                            x: .value("Krypto", data.name),
                            y: .value("Endring (%)", data.value)
                        )
                        .foregroundStyle(by: .value("Tidsramme", data.timeFrame))
                    }
                    .frame(height: 400)
                    .padding()
                } else {
                    Text("Velg minst en kryptovaluta for å vise diagram.")
                        .foregroundColor(.secondary)
                        .padding(.top, 10)
                }
                
                Spacer()
            }
            .padding(.vertical)
            .navigationBarHidden(true)
            .sheet(isPresented: $showSelection) { selectCryptoView() }
            .onAppear {
                viewModel.fetchCryptoList()
                checkForAnimation()
            }
            .overlay(
                // Animasjon
                ZStack {
                    if showEmojis {
                        ForEach(0..<15, id: \.self) { _ in EmojiRainView() }
                    }
                }
            )
        }
    }

    // Lager chart basert på valgte kryptovaluta
    private var chartData: [ChartData] {
        ChartDataConverter.convert(from: viewModel.cryptocurrencies, selectedIDs: selectedIDs)
    }

    // Sjekker om en den overstiger terskelverdien og spiller animasjonen
    private func checkForAnimation() {
        guard let threshold = Int(emojiThreshold), (0...100).contains(threshold) else {
            showEmojis = false
            return
        }
        
        let hasBiggestChange = viewModel.cryptocurrencies.contains { crypto in
            let changes = [crypto.percentChange1h, crypto.percentChange24h, crypto.percentChange7d].compactMap { Double($0) }
            return changes.contains { $0 > Double(threshold) }
        }
        
        if hasBiggestChange {
            showEmojis = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                showEmojis = false
            }
        } else {
            showEmojis = false
        }
    }

    // Visning for valg av kryptovalutaer
    private func selectCryptoView() -> some View {
        NavigationView {
            List(viewModel.cryptocurrencies) { crypto in
                HStack {
                    Text(crypto.name)
                    Spacer()
                    if selectedIDs.contains(crypto.id) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.blue)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    if selectedIDs.contains(crypto.id) {
                        selectedIDs.remove(crypto.id)
                    } else {
                        selectedIDs.insert(crypto.id)
                    }
                }
            }
            .navigationTitle("Velg kryptovaluta")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Ferdig") { showSelection = false }
                }
            }
        }
    }
}

// Animasjonskomponent for emojien
struct EmojiRainView: View {
    @State private var yOffset: CGFloat = -100
    @State private var xOffset: CGFloat = CGFloat.random(in: -150...150)
    
    var body: some View {
        Text("💰")
            .font(.system(size: 40))
            .position(x: UIScreen.main.bounds.width / 2 + xOffset, y: yOffset)
            .onAppear {
                withAnimation(.easeIn(duration: 3)) {
                    yOffset = UIScreen.main.bounds.height + 50
                }
            }
    }
}

