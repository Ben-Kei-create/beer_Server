import Foundation

enum Difficulty: String, CaseIterable, Codable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"

    var localizedName: String {
        switch self {
        case .easy:
            return "初級"
        case .medium:
            return "中級"
        case .hard:
            return "上級"
        }
    }

    var timeLimit: Int {
        switch self {
        case .easy:
            return 25
        case .medium:
            return 20
        case .hard:
            return 18
        }
    }
}
