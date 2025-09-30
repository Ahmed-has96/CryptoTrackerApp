import Foundation

class CoinAPIService {
    static let shared = CoinAPIService()
    
    private let globalStatsURL = "https://api.coinlore.net/api/global/"
    private let cryptoListURL = "https://api.coinlore.net/api/tickers/"

    // Henter global markedsstatistikk
    func fetchGlobalStats(completion: @escaping (Result<GlobalStats, Error>) -> Void) {
        guard let url = URL(string: globalStatsURL) else {
            print("Feil: Ugyldig URL for global stats")
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }

        print("Henter data fra API: \(globalStatsURL)")

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Feil ved nettverkskall: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }

            guard let data = data else {
                print("Ingen data mottatt")
                completion(.failure(NSError(domain: "No Data", code: -2, userInfo: nil)))
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode([GlobalStats].self, from: data)
                if let firstStat = decodedResponse.first {
                    print("Data mottatt: \(firstStat)")
                    completion(.success(firstStat))
                } else {
                    print("Ingen gyldig data i responsen")
                    completion(.failure(NSError(domain: "No Data", code: -3, userInfo: nil)))
                }
            } catch {
                print("JSON-dekodingsfeil: \(error)")
                completion(.failure(error))
            }
        }.resume()
    }

    // Henter liste over kryptovalutaer
    func fetchCryptoList(completion: @escaping (Result<[CryptoCurrency], Error>) -> Void) {
        guard let url = URL(string: cryptoListURL) else {
            print("Feil: Ugyldig URL for kryptovaluta-liste")
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }

        print("Henter kryptovaluta-data fra API: \(cryptoListURL)")

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Feil ved nettverkskall: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }

            guard let data = data else {
                print("Ingen data mottatt")
                completion(.failure(NSError(domain: "No Data", code: -2, userInfo: nil)))
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode(CryptoListResponse.self, from: data)
                print("Kryptovaluta-data mottatt: \(decodedResponse.data.count) valutaer")
                completion(.success(decodedResponse.data))
            } catch {
                print("JSON-dekodingsfeil: \(error)")
                completion(.failure(error))
            }
        }.resume()
    }
}

// Modell for å håndtere API-responsen
struct CryptoListResponse: Decodable {
    let data: [CryptoCurrency]
}

