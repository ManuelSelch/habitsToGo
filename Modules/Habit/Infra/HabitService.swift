import Foundation
import Dependencies
import Combine

class HabitService: ObservableObject {
    @Published var habits: [Habit] = []
    
    func loadAll() -> [Habit] {
        return habits
    }
    
    func save(_ habit: Habit) {
        if let index = habits.firstIndex(where: {$0.id == habit.id}) {
            habits[index] = habit
        } else {
            habits.append(habit)
        }
    }
}

struct HabitServiceKey: DependencyKey {
    static var liveValue = HabitService()
    static var mockValue = liveValue
}

extension DependencyValues {
    var habit: HabitService {
        Self[HabitServiceKey.self]
    }
}
