import Foundation
import SwiftUI

// MARK: - yes / no habit card
struct HabitCard: View {
    let habit: Habit
    let value: Int

    var body: some View {
        VStack {
            HabitIcon(habit.icon, backgroundColor: isDone() ? .theme : .gray)
            
            Text(habit.name)
            Text(habit.description)
                .fontWeight(.regular)
                .foregroundStyle(.gray)
            
            if case let .timed(goal) = habit.type {
                ProcessBar(progress: value, goal: goal)
            }
        }
        .cardStyle(color: isDone() ? .theme : .gray)
    }
    
    func isDone() -> Bool {
        switch habit.type {
        case .positive:
            return value >= 1
        case .timed(let goal):
            return value >= goal
        }
    }
}


// MARK: - Habit Icon
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

// MARK: - Process Bar
@ViewBuilder
func ProcessBar(progress: Int, goal: Int) -> some View {
    VStack {
        // Progress bar
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 6)
                .fill(Color.black)
                .frame(width: 100, height: 12)
            
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


// MARK: - card modifier
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
    ScrollView {
        HabitCard(
            habit: .init(name: "Test", description: "test description", icon: "star", type: .positive),
            value: 0
        )
        
        HabitCard(
            habit: .init(name: "Test", description: "test description", icon: "star", type: .positive),
            value: 1
        )
        
        HabitCard(
            habit: .init(name: "Test", description: "test description", icon: "star", type: .timed(8)),
            value: 0
        )
        
        HabitCard(
            habit: .init(name: "Test", description: "test description", icon: "star", type: .timed(8)),
            value: 4
        )
        
        HabitCard(
            habit: .init(name: "Test", description: "test description", icon: "star", type: .timed(8)),
            value: 8
        )
    }
}

