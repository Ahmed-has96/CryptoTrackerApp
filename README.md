🚀 CryptoTracker App

📱 Description

CryptoTracker is a SwiftUI-based iOS application that fetches real-time cryptocurrency data from the CoinLore API. The app displays global market statistics, price movements, and interactive charts, while offering sorting, currency conversion, and animated UI elements to enhance the user experience.

🛠 Built With

Xcode: 16.2
Swift: 6.0.3
SwiftUI
Combine
Swift Charts
URLSession

✨ Features

Fetches global cryptocurrency market data from the CoinLore API.

* Displays cryptocurrencies in a dynamic list with name and live price.

Advanced sorting:
By rank
1-hour change
24-hour change
7-day change
Ascending and descending order

Detailed view for each cryptocurrency with extended market data.

Pull-to-refresh to retrieve updated API data.

Offline handling:

Displays an error message if launched without internet.

Shows previously fetched data if available.

Outdated data is marked in red to indicate possible staleness.

Automatically refreshes when the app restarts and network is restored.

Interactive statistics tab with selectable cryptocurrencies displayed in charts.

Currency conversion from USD to NOK with toggle functionality.

Emoji animation for significant price changes:

Triggered when the user enters “10”

Or when a cryptocurrency changes by more than 10%

Fully responsive UI that adapts to all iPhone screen sizes.

🌍 API Endpoints

https://api.coinlore.net/api/global/

https://api.coinlore.net/api/tickers/

📚 References

Apple Developer Documentation – SwiftUI

Apple Developer Documentation – Combine

Apple Developer Documentation – Charts

Stack Overflow (for specific implementation challenges)

ChatGPT – Used for debugging support and general SwiftUI development guidance


