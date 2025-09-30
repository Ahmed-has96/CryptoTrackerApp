import Foundation
import SwiftUI

class CryptoListViewModel: ObservableObject {
    
    /// Sporteringsalternativer
    enum SortOption: String, CaseIterable {
        case rank = "Rangering"
        case change1h = "Endring 1t"
        case change24h = "Endring 24t"
        case change7d = "Endring 7d"
    }
    
    @Published var cryptocurrencies: [CryptoCurrency] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var sortOption: SortOption = .rank
    @Published var isAscending: Bool = true
    @AppStorage("nokExchangeRate") private var nokExchangeRate: String = ""

    /// Henter kryptovaluta data fra Apiet
    func fetchCryptoList() {
        isLoading = true
        CoinAPIService.shared.fetchCryptoList { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let cryptos):
                    self?.cryptocurrencies = cryptos
                    self?.sortCryptos()
                case .failure(let error):
                    self?.errorMessage = "Kunne ikke hente kryptovalutaer: \(error.localizedDescription)"
                }
            }
        }
    }

    /// sorterer kryptovalutaer på basert på sorteringsmetode
    func sortCryptos() {
        switch sortOption {
        case .rank:
            cryptocurrencies.sort { isAscending ? $0.rank < $1.rank : $0.rank > $1.rank }
        case .change1h:
            cryptocurrencies.sort { isAscending ? Double($0.percentChange1h)! < Double($1.percentChange1h)! : Double($0.percentChange1h)! > Double($1.percentChange1h)! }
        case .change24h:
            cryptocurrencies.sort { isAscending ? Double($0.percentChange24h)! < Double($1.percentChange24h)! : Double($0.percentChange24h)! > Double($1.percentChange24h)! }
        case .change7d:
            cryptocurrencies.sort { isAscending ? Double($0.percentChange7d)! < Double($1.percentChange7d)! : Double($0.percentChange7d)! > Double($1.percentChange7d)! }
        }
    }

    ///Endrer sorteringsvalg, oppdaterer listen
    func changeSortOption(to newOption: SortOption) {
        sortOption = newOption
        sortCryptos()
    }

    ///bytter mellom stigende og synkende sortering
    func toggleSortOrder() {
        isAscending.toggle()
        sortCryptos()
    }

    ///Koverterer fra usd til nok 
    func formattedPrice(for crypto: CryptoCurrency) -> String {
        guard let usdPrice = Double(crypto.priceUsd), usdPrice > 0 else { return "$0.00" }

        if let nokRate = Double(nokExchangeRate), nokRate > 0 {
            let nokPrice = usdPrice * nokRate
            return String(format: "%.2f kr", nokPrice)
        } else {
            return String(format: "$%.2f", usdPrice)
        }
    }


}
