import SwiftUI

private enum AppRoute: Hashable {
    case quiz
}

struct ContentView: View {
    @State private var questions: [QuizQuestion] = []
    @State private var loadError: String?
    @State private var path: [AppRoute] = []

    var body: some View {
        NavigationStack(path: $path) {
            Group {
                if let loadError {
                    UnavailableView(message: loadError)
                } else if questions.isEmpty {
                    ProgressView("読み込み中")
                } else {
                    HomeView(
                        questionCount: questions.count,
                        startQuiz: { path.append(.quiz) }
                    )
                }
            }
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .quiz:
                    QuizView(session: QuizSession(questions: questions))
                }
            }
            .task {
                loadQuestionsIfNeeded()
            }
        }
    }

    private func loadQuestionsIfNeeded() {
        guard questions.isEmpty, loadError == nil else {
            return
        }

        do {
            questions = try QuestionRepository.loadQuestions()
        } catch {
            loadError = error.localizedDescription
        }
    }
}

#Preview {
    ContentView()
}
