import SwiftUI

struct UnavailableView: View {
    let message: String

    var body: some View {
        ZStack {
            BeerBackdrop()

            BeerPanel {
                ContentUnavailableView(
                    "読み込めませんでした",
                    systemImage: "exclamationmark.triangle",
                    description: Text(message)
                )
                .foregroundStyle(BeerTheme.malt)
            }
            .padding()
        }
    }
}
