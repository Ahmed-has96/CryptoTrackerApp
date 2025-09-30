import SwiftUI

struct CryptoListView: View {
    @StateObject private var viewModel = CryptoListViewModel()

    var body: some View {
        NavigationView {
            VStack {
                // Sorteringskontroller
                Picker("Sorter etter", selection: $viewModel.sortOption) {
                    ForEach(CryptoListViewModel.SortOption.allCases, id: \.self) { option in
                        Text(option.rawValue).tag(option)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                .onChange(of: viewModel.sortOption) { _ in
                    viewModel.sortCryptos()
                }

                // Sorteringsrekkefølge
                Button(action: {
                    viewModel.toggleSortOrder()
                }) {
                    Label(viewModel.isAscending ? "Synkende (Descending)" : "Stigende (Ascending)", systemImage: "arrow.up.arrow.down")
                        .foregroundColor(.blue)
                        .padding()
                }

                if viewModel.isLoading {
                    ProgressView("Laster data...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    List(viewModel.cryptocurrencies) { crypto in
                        NavigationLink(destination: CryptoDetailView(crypto: crypto)) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(crypto.name)
                                        .font(.headline)
                                    Text(crypto.symbol)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                Text(viewModel.formattedPrice(for: crypto))
                                    .font(.headline)
                            }
                            .padding(.vertical, 5)
                        }
                    }
                }
            }
            .navigationTitle("Kryptovalutaer")
            .onAppear {
                viewModel.fetchCryptoList()
            }
        }
    }
}

