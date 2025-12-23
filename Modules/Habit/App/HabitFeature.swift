import Foundation
import Flux
import Dependencies

struct HabitFeature: Feature {
    @Dependency(\.logger) private var logger
    
    nonisolated struct State: Equatable & Sendable {
        
    }
    
    nonisolated enum Action: Equatable & Sendable {
        case confirmHabitTapped(Habit)
    }
    
    nonisolated enum Effect: Equatable & Sendable {
        case saveHabit(Habit)
    }
    
    nonisolated enum Route: Equatable & Hashable & Identifiable & Codable {
        case createHabit
        
        var id: Self { self }
    }
    
    func reduce(_ state: inout State, _ action: Action) -> Effect? {
        logger.debug("\(action)", for: "\(self)")
        
        switch action {
        case .confirmHabitTapped(let habit):
            return .saveHabit(habit)
        }
    }
}
