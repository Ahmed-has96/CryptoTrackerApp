# CryptoTracker · iOS

En SwiftUI-app for å se kryptopriser og sammenligne prisutvikling. Listen kan sorteres etter rangering eller prosentvis endring siste time, døgn eller uke. I innstillingene kan du oppgi en USD–NOK-kurs for å se prisene i kroner.

## Følg dataene gjennom appen

1. [CoinAPIService](CryptoTracker/CryptoTracker/Services/CoinAPIService.swift) henter markedsstatistikk og valutalisten fra CoinLore med URLSession og dekoder JSON-svarene.
2. [CryptoListViewModel](CryptoTracker/CryptoTracker/ViewModels/CryptoListViewModel.swift) sorterer valutaene og formaterer prisene. [CryptoListView](CryptoTracker/CryptoTracker/Views/CryptoListView.swift) viser resultatet i SwiftUI.
3. [ChartDataConverter](CryptoTracker/CryptoTracker/Services/ChartDataConverter.swift) gjør prisendringer om til datapunktene som brukes når du sammenligner valgte valutaer i diagrammet.

## Kjør lokalt

Åpne [CryptoTracker.xcodeproj](CryptoTracker/CryptoTracker.xcodeproj) i Xcode på Mac, velg `CryptoTracker` og kjør på en iPhone-simulator med iOS 18.2 eller nyere. Appen bruker CoinLores offentlige API og trenger ingen API-nøkkel. For å prøve sorteringen, åpne fanen **Krypto**.

## Verktøy

Jeg brukte ChatGPT som støtte til feilsøking og spørsmål om SwiftUI under utviklingen.
