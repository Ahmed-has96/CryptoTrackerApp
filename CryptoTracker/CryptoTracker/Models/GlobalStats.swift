/// Modell for globale statistikker hentet fra API-et.
import Foundation

struct GlobalStats: Codable {
    let coinsCount: Int
    let activeMarkets: Int
    let totalMcap: Double
    let totalVolume: Double
    let btcDominance: String
    let ethDominance: String
    let mcapChange: String
    let volumeChange: String
    let avgChangePercent: String
    let volumeAth: Double
    let mcapAth: Double

    enum CodingKeys: String, CodingKey {
        case coinsCount = "coins_count"
        case activeMarkets = "active_markets"
        case totalMcap = "total_mcap"
        case totalVolume = "total_volume"
        case btcDominance = "btc_d"
        case ethDominance = "eth_d"
        case mcapChange = "mcap_change"
        case volumeChange = "volume_change"
        case avgChangePercent = "avg_change_percent"
        case volumeAth = "volume_ath"
        case mcapAth = "mcap_ath"
    }
}
