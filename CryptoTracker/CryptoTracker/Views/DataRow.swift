import SwiftUI

struct DataRow: View {
    let title: String
    let value: String
    let isOldData: Bool

    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                // Bruk rød farge hvis data er utdatert
                .foregroundColor(isOldData ? Color.red.opacity(0.8) : .primary)

            Spacer()

            Text(value)
                .font(.subheadline)
                .foregroundColor(isOldData ? Color.red.opacity(0.8) : .primary)
        }
        .padding(.vertical, 4)
    }
}

