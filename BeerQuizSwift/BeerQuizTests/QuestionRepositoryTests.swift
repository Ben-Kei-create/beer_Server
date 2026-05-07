import XCTest
@testable import BeerQuiz

final class QuestionRepositoryTests: XCTestCase {
    func testBundledQuestionDataDecodesAndValidates() throws {
        let questions = try QuestionRepository.decodeQuestions(from: bundledQuestionData())

        XCTAssertEqual(questions.count, 75)
        XCTAssertTrue(questions.allSatisfy { $0.choices.count == 4 })
        XCTAssertTrue(questions.allSatisfy { $0.choices.indices.contains($0.correctAnswerIndex) })
    }

    func testSessionScoresCorrectAnswers() throws {
        let questions = try QuestionRepository.decodeQuestions(from: bundledQuestionData())
        var session = QuizSession(questions: Array(questions.prefix(2)), questionLimit: 2, shuffle: false)

        let firstAnswer = session.answerCurrentQuestion(selectedIndex: questions[0].correctAnswerIndex)
        session.moveToNextQuestion()
        let secondAnswer = session.answerCurrentQuestion(selectedIndex: nil)
        session.moveToNextQuestion()

        XCTAssertEqual(firstAnswer?.isCorrect, true)
        XCTAssertEqual(secondAnswer?.isCorrect, false)
        XCTAssertEqual(session.score, 1)
        XCTAssertTrue(session.isComplete)
        XCTAssertEqual(session.answerHistory.count, 2)
    }

    func testValidationRejectsInvalidCorrectAnswerIndex() throws {
        let invalidJSON = """
        [
          {
            "question": "Invalid?",
            "choices": ["A", "B", "C", "D"],
            "correctAnswerIndex": 4,
            "trivia": "Invalid index.",
            "difficulty": "Easy"
          }
        ]
        """.data(using: .utf8)!

        XCTAssertThrowsError(try QuestionRepository.decodeQuestions(from: invalidJSON))
    }

    private func bundledQuestionData() throws -> Data {
        let testFileURL = URL(fileURLWithPath: #filePath)
        let projectRoot = testFileURL
            .deletingLastPathComponent()
            .deletingLastPathComponent()
        let jsonURL = projectRoot.appending(path: "BeerQuiz/Resources/beer_quiz.json")
        return try Data(contentsOf: jsonURL)
    }
}
