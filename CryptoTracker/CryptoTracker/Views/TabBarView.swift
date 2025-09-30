import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Hjem", systemImage: "house")
                }

            CryptoListView()
                .tabItem {
                    Label("Krypto", systemImage: "bitcoinsign.circle")
                }

            CryptoChartView()
                .tabItem {
                    Label("Statistikk", systemImage: "chart.bar.xaxis")
                }

            SettingsView()
                .tabItem {
                    Label("Innstillinger", systemImage: "gearshape")
                }
        }
    }
}

