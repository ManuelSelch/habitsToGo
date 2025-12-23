import SwiftUI

struct DashboardView: View {

    let habits: [Habit]
    
    let habitTapped: (Habit) -> Void
    
    let layout = [
        GridItem(.flexible(minimum: 150, maximum: .infinity)),
        GridItem(.flexible(minimum: 150, maximum: .infinity)),
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: layout) {
                ForEach(habits) { habit in
                    Button(action: { habitTapped(habit) }) {
                        HabitCard(habit: habit, value: 0)
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    DashboardView(
        habits: Habit.sample,
        habitTapped: { _ in }
    )
}
