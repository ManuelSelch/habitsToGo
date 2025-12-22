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
                        switch(habit.type) {
                        case .positive:
                            HabitCard(name: habit.name, icon: habit.icon, done: false)
                        case .timed(let goal):
                            TimedHabitCard(name: habit.name, icon: habit.icon, progress: 1, goal: goal)
                        }
                    }
                }
            }
        }
        .padding()
    }
}

// MARK: - yes / no habit card
struct HabitCard: View {
    let name: String
    let icon: String
    let done: Bool

    var body: some View {
        VStack {
            HabitIcon(icon, backgroundColor: done ? .theme : .gray)
            Text(name)
        }
        .cardStyle(color: done ? .theme : .gray)
    }
}

// MARK: - process habit card
struct TimedHabitCard: View {
    let name: String
    let icon: String
    let progress: Int
    let goal: Int

    var body: some View {
        VStack {
            HabitIcon(icon, backgroundColor: progress == 0 ? .gray : .theme)
            Text(name)
            ProcessBar(progress: progress, goal: goal)
        }
        .cardStyle(color: progress == 0 ? .gray : .theme)
    }
}

@ViewBuilder
func HabitIcon(_ icon: String, backgroundColor: Color = .theme) -> some View {
    ZStack {
        Circle()
            .fill(backgroundColor)
            .frame(width: 60, height: 60)
        
        Image(systemName: icon)
            .font(.system(size: 30, weight: .heavy))
            .foregroundStyle(Color.white)
    }
}

@ViewBuilder
func ProcessBar(progress: Int, goal: Int) -> some View {
    VStack {
        // Progress bar
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 6)
                .fill(Color.black)
                .frame(height: 12)
            
            RoundedRectangle(cornerRadius: 6)
                .fill(Color.theme)
                .frame(width: CGFloat(progress)/CGFloat(goal) * 100, height: 12)
        }
        .frame(maxWidth: .infinity)
        
        Text("\(progress) of \(goal)")
            .font(.caption)
            .foregroundStyle(Color.gray)
    }
}

fileprivate struct CardModifier: ViewModifier {
    var backgroundColor: Color = .white
    var color: Color = .theme
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding() // internal padding
            .background(backgroundColor)
            .font(.system(size: 16, weight: .heavy))
            .foregroundStyle(color)
            .cornerRadius(12)
            .shadow(color: Color.contrast.opacity(0.2), radius: 4, x: 0, y: 2)
            .padding() // external padding
    }
}

extension View {
    fileprivate func cardStyle(color: Color = .theme) -> some View {
        self.modifier(CardModifier(color: color))
    }
}


#Preview {
    DashboardView(
        habits: Habit.sample,
        habitTapped: { _ in }
    )
}
