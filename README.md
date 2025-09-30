# 📱 CryptoTracker App 

## 📝 Description  
CryptoTracker is a SwiftUI application that fetches cryptocurrency data from the CoinLore API and displays market statistics, charts, and price changes. 
It includes interactive features such as sorting, currency conversion, and animations to enhance the user experience.  

This project was developed as an **exam project (grade A)**.  

---

## ⚙️ Versions  
- **Xcode:** 16.2  
- **Swift:** 6.0.3  

---

## Features  
- Fetches **global market data** from the CoinLore API  
- Displays cryptocurrencies in a **list with names and prices**  
- **Sorting** by rank, 1 hour, 24 hours, and 7 days (ascending/descending)  
- **Detailed view** of each cryptocurrency with all relevant information  
- **Pull to refresh** for updated API data  
- **Network error handling:**  
  - No internet → error message  
  - Cached data displayed in red if outdated  
  - Automatically loads fresh data when internet is restored  
- **Interactive statistics tab** with customizable charts  
- **USD ⇄ NOK conversion** with reset option  
- **Emoji animation** for significant price changes (+/−10%)  
- **Responsive UI** for all iPhone sizes  

---

## 📚 Sources and References  
- [CoinLore API – Global](https://api.coinlore.net/api/global/)  
- [CoinLore API – Tickers](https://api.coinlore.net/api/tickers/)  
- [Apple – URLSession with Combine](https://developer.apple.com/documentation/foundation/urlsession/processing_url_session_data_task_results_with_combine)  
- [Apple – SwiftUI Documentation](https://developer.apple.com/documentation/swiftui)  
- [Apple – Charts](https://developer.apple.com/documentation/charts/)  
- [StackOverflow: Pull to Refresh in SwiftUI](https://stackoverflow.com/questions/56493660/pull-down-to-refresh-data-in-swiftui)  
- **ChatGPT** – Used as support for debugging, troubleshooting, and general SwiftUI programming questions  

---
