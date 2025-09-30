import SwiftUI

struct CryptoDetailView: View {
    let crypto: CryptoCurrency
    @StateObject private var viewModel = CryptoListViewModel() //  Legger til ViewModel for prisformattering

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("\(crypto.name) (\(crypto.symbol))")
                .font(.largeTitle)
                .bold()
            
            Text("Rangering: \(crypto.rank)")
                .font(.headline)

            //  Bruker `formattedPrice()` fra `CryptoListViewModel`
            Text("Pris: \(viewModel.formattedPrice(for: crypto))")
                .font(.headline)

            Text("Endring siste time: \(crypto.percentChange1h)%")
                .foregroundColor(Double(crypto.percentChange1h) ?? 0 > 0 ? .green : .red)

            Text("Endring siste 24 timer: \(crypto.percentChange24h)%")
                .foregroundColor(Double(crypto.percentChange24h) ?? 0 > 0 ? .green : .red)

            Text("Endring siste 7 dager: \(crypto.percentChange7d)%")
                .foregroundColor(Double(crypto.percentChange7d) ?? 0 > 0 ? .green : .red)
        }
        .padding()
        .navigationTitle(crypto.name)
    }
}

