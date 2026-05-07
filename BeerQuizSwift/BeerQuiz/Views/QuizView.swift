import SwiftUI

struct QuizView: View {
    @Environment(\.dismiss) private var dismiss

    @State var session: QuizSession
    @State private var selectedIndex: Int?
    @State private var lastAnswer: AnswerRecord?
    @State private var timeRemaining: Int

    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    init(session: QuizSession) {
        _session = State(initialValue: session)
        _timeRemaining = State(initialValue: session.currentQuestion?.difficulty.timeLimit ?? 20)
    }

    var body: some View {
        ZStack {
            BeerBackdrop()

            if session.isComplete {
                ResultView(session: session, restart: restart, close: { dismiss() })
            } else if let question = session.currentQuestion {
                questionBody(question)
            } else {
                UnavailableView(message: "表示できる問題がありません。")
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Text("Score \(session.score)")
                    .font(.subheadline.weight(.bold))
                    .foregroundStyle(BeerTheme.malt)
            }
        }
        .onReceive(timer) { _ in
            guard lastAnswer == nil, !session.isComplete else {
                return
            }

            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                submitAnswer(nil)
            }
        }
    }

    private func questionBody(_ question: QuizQuestion) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                statusBar

                BeerPanel {
                    VStack(alignment: .leading, spacing: 14) {
                        BeerChip(title: question.difficulty.localizedName, color: difficultyColor(question.difficulty))

                        Text(question.question)
                            .font(.title2.weight(.black))
                            .foregroundStyle(BeerTheme.malt)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }

                VStack(spacing: 12) {
                    ForEach(question.choices.indices, id: \.self) { index in
                        ChoiceButton(
                            text: question.choices[index],
                            state: choiceState(for: index, question: question),
                            action: { submitAnswer(index) }
                        )
                        .disabled(lastAnswer != nil)
                    }
                }

                if let lastAnswer {
                    AnswerExplanationView(answer: lastAnswer, action: continueQuiz)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 18)
        }
        .scrollIndicators(.hidden)
    }

    private var statusBar: some View {
        BeerPanel(cornerRadius: 22) {
            VStack(spacing: 12) {
                HStack {
                    Label(session.progressText, systemImage: "chart.bar.fill")
                        .font(.headline.weight(.bold))
                        .foregroundStyle(BeerTheme.malt)

                    Spacer()

                    Label("\(timeRemaining)", systemImage: "timer")
                        .font(.headline.monospacedDigit().weight(.bold))
                        .foregroundStyle(timeRemaining <= 5 ? BeerTheme.berry : BeerTheme.hop)
                }

                ProgressView(value: Double(session.currentIndex + 1), total: Double(session.questions.count))
                    .tint(BeerTheme.deepAmber)
            }
        }
    }

    private func choiceState(for index: Int, question: QuizQuestion) -> ChoiceButton.State {
        guard let lastAnswer else {
            return selectedIndex == index ? .selected : .idle
        }

        if index == question.correctAnswerIndex {
            return .correct
        }

        if lastAnswer.selectedIndex == index {
            return .incorrect
        }

        return .idle
    }

    private func submitAnswer(_ index: Int?) {
        guard lastAnswer == nil else {
            return
        }

        selectedIndex = index
        lastAnswer = session.answerCurrentQuestion(selectedIndex: index)
    }

    private func continueQuiz() {
        if session.isLastQuestion {
            session.moveToNextQuestion()
            return
        }

        session.moveToNextQuestion()
        selectedIndex = nil
        lastAnswer = nil
        timeRemaining = session.currentQuestion?.difficulty.timeLimit ?? 20
    }

    private func restart() {
        let sourceQuestions = session.questions
        session = QuizSession(questions: sourceQuestions, questionLimit: sourceQuestions.count, shuffle: true)
        selectedIndex = nil
        lastAnswer = nil
        timeRemaining = session.currentQuestion?.difficulty.timeLimit ?? 20
    }

    private func difficultyColor(_ difficulty: Difficulty) -> Color {
        switch difficulty {
        case .easy:
            return BeerTheme.skyFoam
        case .medium:
            return BeerTheme.amber
        case .hard:
            return BeerTheme.berry
        }
    }
}

private struct ChoiceButton: View {
    enum State {
        case idle
        case selected
        case correct
        case incorrect
    }

    let text: String
    let state: State
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: iconName)
                    .frame(width: 24)

                Text(text)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(backgroundColor, in: RoundedRectangle(cornerRadius: 12))
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderColor, lineWidth: 1)
            }
        }
        .buttonStyle(.plain)
        .foregroundStyle(.primary)
    }

    private var iconName: String {
        switch state {
        case .idle:
            "circle"
        case .selected:
            "largecircle.fill.circle"
        case .correct:
            "checkmark.circle.fill"
        case .incorrect:
            "xmark.circle.fill"
        }
    }

    private var backgroundColor: Color {
        switch state {
        case .idle:
            Color.white.opacity(0.62)
        case .selected:
            BeerTheme.amber.opacity(0.26)
        case .correct:
            BeerTheme.hop.opacity(0.22)
        case .incorrect:
            BeerTheme.berry.opacity(0.18)
        }
    }

    private var borderColor: Color {
        switch state {
        case .idle:
            Color.white.opacity(0.58)
        case .selected:
            BeerTheme.deepAmber
        case .correct:
            BeerTheme.hop
        case .incorrect:
            BeerTheme.berry
        }
    }
}

private struct AnswerExplanationView: View {
    let answer: AnswerRecord
    let action: () -> Void

    var body: some View {
        BeerPanel {
            VStack(alignment: .leading, spacing: 12) {
                Label(answer.isCorrect ? "正解です" : "答えを確認", systemImage: answer.isCorrect ? "checkmark.seal.fill" : "lightbulb.fill")
                    .font(.headline)
                    .foregroundStyle(answer.isCorrect ? BeerTheme.hop : BeerTheme.deepAmber)

                Text("正解: \(answer.question.correctChoice)")
                    .font(.subheadline.bold())
                    .foregroundStyle(BeerTheme.malt)

                Text(answer.question.trivia)
                    .font(.body)
                    .foregroundStyle(BeerTheme.malt.opacity(0.82))

                Button(action: action) {
                    Label("次へ", systemImage: "arrow.right")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(BeerPrimaryButtonStyle())
            }
        }
    }
}

#Preview {
    QuizView(
        session: QuizSession(
            questions: [
                QuizQuestion(
                    question: "ビールの泡が香りを守る理由は？",
                    choices: ["香りを閉じ込めるため", "色を変えるため", "温度を上げるため", "苦味を消すため"],
                    correctAnswerIndex: 0,
                    trivia: "泡は香りを保ち、口当たりも整えます。",
                    difficulty: .medium
                )
            ],
            shuffle: false
        )
    )
}
