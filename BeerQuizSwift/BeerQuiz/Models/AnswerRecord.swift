import Foundation

struct AnswerRecord: Equatable, Identifiable {
    let id = UUID()
    let question: QuizQuestion
    let selectedIndex: Int?

    var isCorrect: Bool {
        selectedIndex == question.correctAnswerIndex
    }

    var selectedText: String {
        guard let selectedIndex, question.choices.indices.contains(selectedIndex) else {
            return "時間切れ"
        }

        return question.choices[selectedIndex]
    }
}
