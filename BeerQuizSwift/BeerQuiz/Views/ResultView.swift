import SwiftUI

struct ResultView: View {
    let session: QuizSession
    let restart: () -> Void
    let close: () -> Void

    private var percentage: Int {
        guard !session.questions.isEmpty else {
            return 0
        }

        return Int((Double(session.score) / Double(session.questions.count) * 100).rounded())
    }

    var body: some View {
        ZStack {
            BeerBackdrop()

            ScrollView {
                VStack(spacing: 22) {
                    BeerPanel(cornerRadius: 28) {
                        VStack(spacing: 10) {
                            Text("\(session.score) / \(session.questions.count)")
                                .font(.system(size: 56, weight: .black, design: .rounded))
                                .foregroundStyle(BeerTheme.malt)

                            Text("正答率 \(percentage)%")
                                .font(.title3.weight(.bold))
                                .foregroundStyle(BeerTheme.hop)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                    }

                    VStack(spacing: 12) {
                        Button(action: restart) {
                            Label("もう一度挑戦", systemImage: "arrow.clockwise")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(BeerPrimaryButtonStyle())

                        Button(action: close) {
                            Label("ホームに戻る", systemImage: "house.fill")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(BeerSecondaryButtonStyle())
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Text("解答履歴")
                            .font(.headline.weight(.bold))
                            .foregroundStyle(BeerTheme.malt)

                        ForEach(session.answerHistory) { answer in
                            HStack(alignment: .top, spacing: 10) {
                                Image(systemName: answer.isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                                    .foregroundStyle(answer.isCorrect ? BeerTheme.hop : BeerTheme.berry)
                                    .padding(.top, 2)

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(answer.question.question)
                                        .font(.subheadline.weight(.semibold))
                                        .foregroundStyle(BeerTheme.malt)
                                    Text("あなたの答え: \(answer.selectedText)")
                                        .font(.caption)
                                        .foregroundStyle(BeerTheme.malt.opacity(0.66))
                                }
                            }
                            .padding()
                            .background(Color.white.opacity(0.58), in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                        }
                    }
                    .padding(18)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 18)
            }
            .scrollIndicators(.hidden)
        }
        .navigationTitle("結果")
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    let question = QuizQuestion(
        question: "IPAで香りを与える材料は？",
        choices: ["ホップ", "米", "塩", "水飴"],
        correctAnswerIndex: 0,
        trivia: "ホップはビールに香りと苦味を与えます。",
        difficulty: .easy
    )
    var session = QuizSession(questions: [question], shuffle: false)
    _ = session.answerCurrentQuestion(selectedIndex: 0)
    session.moveToNextQuestion()
    return ResultView(session: session, restart: {}, close: {})
}
