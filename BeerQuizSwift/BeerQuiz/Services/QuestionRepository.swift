import Foundation

enum QuestionRepositoryError: Error, LocalizedError {
    case missingResource
    case emptyQuestionBank
    case invalidQuestion(index: Int, reason: String)

    var errorDescription: String? {
        switch self {
        case .missingResource:
            return "問題データが見つかりませんでした。"
        case .emptyQuestionBank:
            return "問題データが空です。"
        case let .invalidQuestion(index, reason):
            return "問題データ \(index + 1) 件目に不備があります: \(reason)"
        }
    }
}

enum QuestionRepository {
    static func loadQuestions(from bundle: Bundle = .main) throws -> [QuizQuestion] {
        guard let url = bundle.url(forResource: "beer_quiz", withExtension: "json") else {
            throw QuestionRepositoryError.missingResource
        }

        let data = try Data(contentsOf: url)
        return try decodeQuestions(from: data)
    }

    static func decodeQuestions(from data: Data) throws -> [QuizQuestion] {
        let decoder = JSONDecoder()
        let questions = try decoder.decode([QuizQuestion].self, from: data)
        try validate(questions)
        return questions
    }

    static func validate(_ questions: [QuizQuestion]) throws {
        guard !questions.isEmpty else {
            throw QuestionRepositoryError.emptyQuestionBank
        }

        for (index, question) in questions.enumerated() {
            if question.question.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                throw QuestionRepositoryError.invalidQuestion(index: index, reason: "question is empty")
            }

            if question.choices.count != 4 {
                throw QuestionRepositoryError.invalidQuestion(index: index, reason: "choices must be exactly 4")
            }

            if question.choices.contains(where: { $0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }) {
                throw QuestionRepositoryError.invalidQuestion(index: index, reason: "choice is empty")
            }

            if !question.choices.indices.contains(question.correctAnswerIndex) {
                throw QuestionRepositoryError.invalidQuestion(index: index, reason: "correctAnswerIndex is out of range")
            }

            if question.trivia.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                throw QuestionRepositoryError.invalidQuestion(index: index, reason: "trivia is empty")
            }
        }
    }
}
