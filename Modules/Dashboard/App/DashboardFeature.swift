import Foundation
import Flux
import Router
import Dependencies

struct DashboardFeature: Feature {
    @Dependency(\.logger) private var logger
    
    // MARK: - Action
    nonisolated enum Action: Equatable, Sendable {
        // user intents
        case habitTapped(Habit)
        
        // results
        case habitsLoaded([Habit])
        case habitCreated(Habit)
    }

    // MARK: - State
    nonisolated struct State: Equatable, Sendable {
        var habits: [Habit] = []
        var entries: [HabitEntry] = []
    }
    
    // MARK: - Effect
    nonisolated enum Effect: Equatable, Sendable {
        case loadHabits
        case saveEntry(HabitEntry)
    }
    
    // MARK: - reduce
    func reduce(_ state: inout State, _ action: Action) -> Effect? {
        logger.debug("\(action)", for: "\(self)")
        
        switch(action) {
        
        // user intends
        case .habitTapped(let habit):
            // todo: check type (positive / timed)
            let entry = incrementProcess(habit.id, in: &state.entries)
            return .saveEntry(entry)
            
        // results
        case .habitsLoaded(let habits):
            state.habits = habits
        case .habitCreated(let habit):
            state.habits.append(habit)
        }
        
        return .none
    }
    
    func incrementProcess(_ habitID: String, in entries: inout [HabitEntry]) -> HabitEntry {
        // update existing entry
        if let index = currentIndex(habitID, in: entries) {
            entries[index].value += 1
            return entries[index]
        }
        
        // create new entry
        let entry = HabitEntry(habitID: habitID, date: .now, value: 1)
        entries.append(entry)
        return entry
        
    }
    
    func currentIndex(_ habitID: String, in entries: [HabitEntry]) -> Int? {
        return entries.firstIndex(where: {
            $0.habitID == habitID &&
            Calendar.current.isDate($0.date, inSameDayAs: .now)
        })
    }
}
