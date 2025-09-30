import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = GlobalStatsViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Laster data...")
                }

                if let stats = viewModel.globalStats {
                    List {
                        Section(header: Text("MARKEDSOVERSIKT")
                            .font(.caption)
                            .foregroundColor(.gray)) {
                                
                            // Viser forskjellige statistikker
                            DataRow(title: "Antall Coins",
                                    value: "\(stats.coinsCount)",
                                    isOldData: viewModel.hasOldData)
                            
                            DataRow(title: "Aktive Markeder",
                                    value: "\(stats.activeMarkets)",
                                    isOldData: viewModel.hasOldData)
                            
                            DataRow(title: "Markedsverdi (USD)",
                                    value: formatFullNumber(stats.totalMcap),
                                    isOldData: viewModel.hasOldData)
                            
                            DataRow(title: "Totalt Volum",
                                    value: formatFullNumber(stats.totalVolume),
                                    isOldData: viewModel.hasOldData)
                            
                            DataRow(title: "BTC Dominans",
                                    value: "\(stats.btcDominance)%",
                                    isOldData: viewModel.hasOldData)
                            
                            DataRow(title: "ETH Dominans",
                                    value: "\(stats.ethDominance)%",
                                    isOldData: viewModel.hasOldData)
                            
                            DataRow(title: "Markedsverdi Endring",
                                    value: "\(stats.mcapChange)%",
                                    isOldData: viewModel.hasOldData)
                            
                            DataRow(title: "Volum Endring",
                                    value: "\(stats.volumeChange)%",
                                    isOldData: viewModel.hasOldData)
                            
                            DataRow(title: "Gjennomsnittlig Endring",
                                    value: "\(stats.avgChangePercent)%",
                                    isOldData: viewModel.hasOldData)
                            
                            DataRow(title: "Høyeste Volum",
                                    value: formatFullNumber(stats.volumeAth),
                                    isOldData: viewModel.hasOldData)
                            
                            DataRow(title: "Høyeste Markedsverdi",
                                    value: formatFullNumber(stats.mcapAth),
                                    isOldData: viewModel.hasOldData)
                        }
                    }
                    .refreshable {
                        viewModel.loadGlobalStats()
                    }
                }
                
                // Viser feilmelding dersom data ikke kunne hentes
                if viewModel.globalStats == nil, let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                }
            }
            .navigationTitle("Hjem")
            .onAppear {
                viewModel.loadGlobalStats()
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Nettverksfeil"),
                      message: Text("Du har mistet nettverket. Data kan være utdatert."),
                      dismissButton: .default(Text("OK")))
            }
        }
    }
    
    // formater tallene sånn at det er lettere å lese
    private func formatFullNumber(_ number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        formatter.usesGroupingSeparator = true
        return formatter.string(from: NSNumber(value: number)) ?? "\(number)"
    }
}

