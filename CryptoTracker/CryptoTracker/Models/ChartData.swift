/// Modell for å representere data i diagrammet.
import Foundation
struct ChartData: Identifiable {
    let id = UUID()
    let name: String       
    let timeFrame: String
    let value: Double
}
