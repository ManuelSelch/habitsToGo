import Foundation
import Flux
import Router

struct DashboardFeature: Feature {
    nonisolated enum Action: Equatable, Sendable {
        case onAppear
        case habitTapped(Habit)
        case createHabitTapped
        case habitCreated(Habit)
    }

    nonisolated struct State: Equatable, Sendable {
        var habits: [Habit] = []
    }
    
    func reduce(_ state: inout State, _ action: Action) {
        switch(action) {
        case .onAppear: break
        case .habitTapped: break
        case .createHabitTapped:
            MyRouter.shared.showSheet(.createHabitSheet)
        case .habitCreated(let habit):
            MyRouter.shared.dismiss()
            state.habits.append(habit)
        }
    }
}
