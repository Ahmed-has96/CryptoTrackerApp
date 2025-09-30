import SwiftUI

struct SettingsView: View {
    @AppStorage("nokExchangeRate") private var nokExchangeRate: String = "" // Standard er USD
    @FocusState private var isTextFieldFocused: Bool

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("VALUTAINNSTILLINGER").font(.caption).foregroundColor(.gray)) {
                    HStack {
                        Text("NOK per USD:")
                        Spacer()
                        TextField("Valutakurs", text: $nokExchangeRate)
                            .keyboardType(.decimalPad)
                            .frame(width: 80)
                            .multilineTextAlignment(.trailing)
                            .focused($isTextFieldFocused)
                            .onChange(of: nokExchangeRate) { newValue in
                                
                                nokExchangeRate = newValue.replacingOccurrences(of: ",", with: ".")
                                
                                // forsikrer seg verdien er et gyldig tall
                                if Double(nokExchangeRate) == nil || nokExchangeRate.isEmpty {
                                    nokExchangeRate = "0"
                                }
                            }
                    }

                    // Nullstill-knapp for å bruke USD
                    Button(action: {
                        nokExchangeRate = "0"
                        isTextFieldFocused = false
                    }) {
                        Text("Nullstill til USD")
                            .foregroundColor(.red)
                    }
                }

                Text("Alle USD vil bli konvertert til NOK basert på denne kursen. Nullstill for å bruke USD.")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.top, -10)
            }
            .navigationTitle("Innstillinger")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Lagre") {
                        isTextFieldFocused = false
                        if Double(nokExchangeRate) == nil {
                            nokExchangeRate = "0" //  Hvis verdien ikke er gyldig, bruk USD
                        }
                    }
                    .font(.headline)
                }
            }
        }
    }
}

