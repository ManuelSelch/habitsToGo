import Foundation
import Flux
import Router
import Dependencies

struct DashboardFeature: Feature {
    nonisolated enum Action: Equatable, Sendable {
        // liefecycle
        case onAppear
        
        // user intents
        case createHabitTapped
        case createHabitConfirmed(Habit)
        case habitTapped(Habit)
        
        // results
        case habitCreated(Habit)
    }

    nonisolated struct State: Equatable, Sendable {
        var habits: [Habit] = []
    }
    
    nonisolated enum Effect: Equatable, Sendable {
        case showCreateHabitSheet
        case saveHabit(Habit)
    }
    
    func reduce(_ state: inout State, _ action: Action) -> Effect? {
        switch(action) {
        case .onAppear: break
            
        case .createHabitTapped:
            return .showCreateHabitSheet
        
        case .createHabitConfirmed(let habit):
            return .saveHabit(habit)
            
        case .habitTapped(let habit): break
            
        case .habitCreated(let habit):
            state.habits.append(habit)
        }
        
        return .none
    }
}
