import Foundation

struct HabitEntry: Identifiable, Sendable, Equatable {
    let habitID: String
    let date: Date
    var value: Int
    
    var id: String {
        "\(habitID)_\(date)"
    }
}

