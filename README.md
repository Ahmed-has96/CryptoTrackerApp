
#CryptoTracker App

#Beskrivelse
CryptoTracker er en SwiftUI-app som henter kryptovalutadata fra CoinLore API og viser markedsstatistikk, grafer og prisendringer. Den inkluderer interaktive funksjoner som sortering, valutakonvertering og animasjoner for å forbedre brukeropplevelsen.

## Versjoner
###Prosjektet er utviklet og testet med
- Xcode: 16.2
- Swift: 6.0.3




## Funksjoner
- Henter globale markedsdata fra API-et CoinLore.
- Viser kryptovalutaer i en liste med navn og pris.
- Sortering av kryptovalutaer etter rangering, 1 time, 24 timer og 7 dager, både stigende og synkende.
- Detaljert visning av en kryptovaluta med all relevant informasjon.
- "Pull to refresh" for å hente oppdaterte data fra API-et.
- Håndtering av nettverksfeil: Hvis brukeren starter appen uten nettverk, vises en feilmelding. Hvis tidligere hentede data finnes, vises disse, men markeres med rød farge for å indikere at de kan være utdaterte. Når nettverket kommer tilbake, og appen startes på nytt, lastes de nyeste dataene automatisk
- Interaktiv statistikkfane som lar brukeren velge kryptovalutaer som vises i et diagramet.
- Konvertering fra USD til NOK knapp for nulltille tilbake til USD.
- Emoji-animasjon ved store kursendringer, Hvis brukeren skriver tallet 10, eller en kryptovaluta har en endring på over 10%, vises animasjonen.
- Responsivt UI som tilpasser seg alle iPhone-størrelser.



### Kilder og referanser
 https://api.coinlore.net/api/global/
 https://api.coinlore.net/api/tickers/ 
 https://developer.apple.com/documentation/foundation/urlsession/processing_url_session_data_task_results_with_combine
 https://developer.apple.com/documentation/swiftui
 https://developer.apple.com/documentation/swiftui
 https://developer.apple.com/documentation/charts/
 https://stackoverflow.com/
 https://stackoverflow.com/questions/56493660/pull-down-to-refresh-data-in-swiftui
 ChatGPT – Brukt som en støtte for feilsøking, debugging og generelle programmeringsspørsmål i SwiftUI


