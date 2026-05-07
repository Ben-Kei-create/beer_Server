import Foundation

struct QuizSession {
    private(set) var questions: [QuizQuestion]
    private(set) var currentIndex: Int = 0
    private(set) var score: Int = 0
    private(set) var answerHistory: [AnswerRecord] = []

    init(questions: [QuizQuestion], questionLimit: Int = 10, shuffle: Bool = true) {
        let preparedQuestions = shuffle ? questions.shuffled() : questions
        self.questions = Array(preparedQuestions.prefix(questionLimit))
    }

    var currentQuestion: QuizQuestion? {
        guard questions.indices.contains(currentIndex) else {
            return nil
        }

        return questions[currentIndex]
    }

    var progressText: String {
        "\(min(currentIndex + 1, questions.count)) / \(questions.count)"
    }

    var isComplete: Bool {
        currentIndex >= questions.count
    }

    var isLastQuestion: Bool {
        currentIndex == questions.count - 1
    }

    mutating func answerCurrentQuestion(selectedIndex: Int?) -> AnswerRecord? {
        guard let question = currentQuestion else {
            return nil
        }

        let record = AnswerRecord(question: question, selectedIndex: selectedIndex)
        answerHistory.append(record)

        if record.isCorrect {
            score += 1
        }

        return record
    }

    mutating func moveToNextQuestion() {
        currentIndex += 1
    }
}
