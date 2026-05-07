import Foundation

struct QuizQuestion: Codable, Equatable, Identifiable {
    var id: String { question }

    let question: String
    let choices: [String]
    let correctAnswerIndex: Int
    let trivia: String
    let difficulty: Difficulty

    var correctChoice: String {
        choices[correctAnswerIndex]
    }
}
