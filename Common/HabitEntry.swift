import Foundation

struct HabitEntry: Identifiable, Sendable {
    let id: UUID
    let habitID: UUID
    let date: Date
    var value: Int
}

