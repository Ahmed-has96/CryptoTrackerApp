/// Modell for kryptovaluta-data hentet fra API.  
import Foundation

struct CryptoCurrency: Identifiable, Codable {
    let id: String
    let name: String
    let symbol: String
    let rank: Int
    let priceUsd: String
    let percentChange1h: String
    let percentChange24h: String
    let percentChange7d: String

    enum CodingKeys: String, CodingKey {
        case id, name, symbol, rank
        case priceUsd = "price_usd"
        case percentChange1h = "percent_change_1h"
        case percentChange24h = "percent_change_24h"
        case percentChange7d = "percent_change_7d"
    }
}

