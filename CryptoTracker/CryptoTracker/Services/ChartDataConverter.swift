
import Foundation
import Foundation

class ChartDataConverter {
    // Konverterer kryptodata til diagram
    static func convert(from cryptocurrencies: [CryptoCurrency], selectedIDs: Set<String>) -> [ChartData] {
        let filtered = cryptocurrencies.filter { selectedIDs.contains($0.id) }
        
        // Lager diagram for 1h, 24h og 7d
        return filtered.flatMap { crypto in
            let oneHour = Double(crypto.percentChange1h) ?? 0
            let oneDay  = Double(crypto.percentChange24h) ?? 0
            let oneWeek = Double(crypto.percentChange7d) ?? 0
            
            return [
                ChartData(name: crypto.name, timeFrame: "1h", value: oneHour),
                ChartData(name: crypto.name, timeFrame: "24h", value: oneDay),
                ChartData(name: crypto.name, timeFrame: "7d", value: oneWeek)
            ]
        }
    }
}
