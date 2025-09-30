import Foundation
import Network
import Combine

class GlobalStatsViewModel: ObservableObject {
    @Published var globalStats: GlobalStats?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isOffline = false
    @Published var hasOldData = false
    @Published var showAlert = false

    private var monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")

    init() {
        setupNetworkMonitor()
        loadGlobalStats()
    }

    /// Følger med på netverksstatusen og oppdaterer status
    private func setupNetworkMonitor() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                let previousState = self?.isOffline ?? false
                
                self?.isOffline = (path.status != .satisfied)
                if self?.isOffline == true {
                    self?.showAlert = true
                }
                if previousState == true && self?.isOffline == false {
                    self?.loadGlobalStats()
                }
            }
        }
        monitor.start(queue: queue)
    }

    ///Henter statestikk fra apiet
    func loadGlobalStats() {
        if isOffline {
            DispatchQueue.main.async {
                
                if self.globalStats == nil {
                    self.errorMessage = "Ingen nettverkstilkobling."
                } else {
                    self.errorMessage = nil
                    self.hasOldData = true
                }
            }
            return
        }

        // starter api-kallet
        isLoading = true
        errorMessage = nil

        CoinAPIService.shared.fetchGlobalStats { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false

                switch result {
                case .success(let stats):
                    self?.globalStats = stats
                    self?.hasOldData = false

                case .failure(let error):
                    self?.errorMessage = "Kunne ikke hente data: \(error.localizedDescription)"
                    
                    //hvis den er gammel markeres den som utadert
                    if self?.globalStats != nil {
                        self?.hasOldData = true
                    }
                }
            }
        }
    }
}

