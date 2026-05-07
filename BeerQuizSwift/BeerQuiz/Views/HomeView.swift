import SwiftUI

struct HomeView: View {
    let questionCount: Int
    let startQuiz: () -> Void

    var body: some View {
        ZStack {
            BeerBackdrop()

            ScrollView {
                VStack(alignment: .leading, spacing: 22) {
                    hero
                    stats
                    startButton
                    notice
                }
                .padding(.horizontal, 20)
                .padding(.top, 40)
                .padding(.bottom, 28)
            }
            .scrollIndicators(.hidden)
        }
    }

    private var hero: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack(alignment: .center, spacing: 14) {
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.72))
                        .frame(width: 64, height: 64)
                    Image(systemName: "sparkles")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(BeerTheme.deepAmber)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text("泡立つ雑学")
                        .font(.caption.weight(.bold))
                        .foregroundStyle(BeerTheme.hop)
                    Text("ビール雑学クイズ")
                        .font(.system(size: 34, weight: .black, design: .rounded))
                        .foregroundStyle(BeerTheme.malt)
                        .minimumScaleFactor(0.80)
                        .lineLimit(1)
                }
                .layoutPriority(1)
            }

            Text("注ぎ方、スタイル、醸造の知識を、軽やかな泡みたいにテンポよく。")
                .font(.title3.weight(.semibold))
                .foregroundStyle(BeerTheme.malt.opacity(0.78))
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.top, 18)
    }

    private var stats: some View {
        BeerPanel {
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 12) {
                    StatBadge(title: "問題数", value: "\(questionCount)問", symbol: "circle.grid.2x2.fill")
                    StatBadge(title: "1回", value: "10問", symbol: "timer")
                }

                HStack(spacing: 10) {
                    BeerChip(title: "初級", color: BeerTheme.skyFoam)
                    BeerChip(title: "中級", color: BeerTheme.amber)
                    BeerChip(title: "上級", color: BeerTheme.berry)
                }
            }
        }
    }

    private var startButton: some View {
        Button(action: startQuiz) {
            Label("スタート", systemImage: "play.fill")
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(BeerPrimaryButtonStyle())
        .accessibilityIdentifier("start_quiz_button")
    }

    private var notice: some View {
        BeerPanel(cornerRadius: 22) {
            VStack(alignment: .leading, spacing: 12) {
                Label("お酒は20歳になってから", systemImage: "exclamationmark.triangle.fill")
                    .font(.headline)
                    .foregroundStyle(BeerTheme.deepAmber)

                Link(
                    "プライバシーポリシー",
                    destination: URL(string: "https://ben-kei-create.github.io/beer_Server/privacy-policy.html")!
                )
                .font(.callout.weight(.semibold))
                .foregroundStyle(BeerTheme.hop)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

private struct StatBadge: View {
    let title: String
    let value: String
    let symbol: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Label(title, systemImage: symbol)
                .font(.caption.weight(.bold))
                .foregroundStyle(BeerTheme.hop)
            Text(value)
                .font(.system(size: 28, weight: .black, design: .rounded))
                .foregroundStyle(BeerTheme.malt)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(Color.white.opacity(0.62), in: RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}

#Preview {
    HomeView(questionCount: 75, startQuiz: {})
}
