import Foundation

struct Habit: Identifiable, Equatable, Sendable {
    let name: String
    let description: String
    let icon: String
    let type: HabitType
    
    var id: String { name }
}

enum HabitType: Identifiable, Hashable, Sendable {
    case positive
    case timed(_ goal: Int)
    
    var id: Self { self }
}

extension Habit {
    static let sample: [Habit] = [
        .init(name: "Reading",  description: "reading description",     icon: "book.closed.fill",                   type: .positive),
        .init(name: "Coding",   description: "coding description",      icon: "macbook",                            type: .positive),
        .init(name: "Swimming", description: "swimming description",    icon: "figure.open.water.swim.circle.fill", type: .positive),
        .init(name: "Sleeping", description: "sleeping description",    icon: "powersleep",                         type: .timed(8))
    ]
}
