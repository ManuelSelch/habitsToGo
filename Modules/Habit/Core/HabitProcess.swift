import Foundation
 
typealias HabitProcessMap = [Habit.ID: [TrackingPeriod: HabitProgress]]

nonisolated struct HabitProgress: Equatable, Sendable {
    let habitID: Habit.ID
    let period: TrackingPeriod
    var value: Int
    
    init(habitID: Habit.ID, period: TrackingPeriod) {
        self.habitID = habitID
        self.period = period
        self.value = 0
    }
}

nonisolated struct HabitProgressState: Equatable {
    var progress: HabitProcessMap = [:]
    
    mutating func increment(
        habit: Habit,
        period: TrackingPeriod
    ) {
        var habitProgress = progress[habit.id] ?? [:]
        var entry = habitProgress[period] ?? .init(habitID: habit.id, period: period)

        entry.value += 1
        
        habitProgress[period] = entry
        progress[habit.id] = habitProgress
    }
    
    func getToday(_ habit: Habit) -> Int {
        return get(habit, in: .today())
    }
    
    func get(_ habit: Habit, in period: TrackingPeriod) -> Int {
        progress[habit.id]?[.today()]?.value ?? 0
    }
    
}
