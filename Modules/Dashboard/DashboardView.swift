import SwiftUI

struct DashboardView: View {
    let layout = [
        GridItem(.flexible(minimum: 150, maximum: .infinity)),
        GridItem(.flexible(minimum: 150, maximum: .infinity)),
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: layout) {
                HabitCard("Reading", icon: "book.closed.fill")
                HabitCard("Coding", icon: "macbook")
                HabitCard("Swimming", icon: "figure.open.water.swim.circle.fill")
                
                ProcessHabitCard("Sleeping", icon: "powersleep", progress: 6, goal: 8, onIncrement: {})
            }
        }
        .padding()
    }
}

// MARK: - yes / no habit card
@ViewBuilder
func HabitCard(_ name: String, icon: String) -> some View {
    VStack {
        HabitIcon(icon)
        
        Text(name)
    }
    .cardStyle()
}

// MARK: - process habit card
@ViewBuilder
func ProcessHabitCard(_ name: String, icon: String, progress: Int, goal: Int, onIncrement: @escaping () -> Void) -> some View {
    VStack {
        HabitIcon(icon)
        
        Text(name)
        
        ProcessBar(progress: progress, goal: goal, onIncrement: onIncrement)
    }
    .frame(maxWidth: .infinity)
    .cardStyle()
   
}

@ViewBuilder
func HabitIcon(_ icon: String) -> some View {
    ZStack {
        Circle()
            .fill(Color.theme)
            .frame(width: 60, height: 60)
        
        Image(systemName: icon)
            .font(.system(size: 30, weight: .heavy))
            .foregroundStyle(Color.white)
    }
}

@ViewBuilder
func ProcessBar(progress: Int, goal: Int, onIncrement: @escaping () -> ()) -> some View {
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
        .onTapGesture {
            onIncrement()
        }
        
        Text("\(progress) of \(goal)")
            .font(.caption)
            .foregroundStyle(Color.gray)
    }
}

fileprivate struct CardModifier: ViewModifier {
    var cornerRadius: CGFloat = 12
    var shadowRadius: CGFloat = 4
    var backgroundColor: Color = .white
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding() // internal padding
            .background(backgroundColor)
            .font(.system(size: 16, weight: .heavy))
            .foregroundStyle(Color.theme)
            .cornerRadius(cornerRadius)
            .shadow(color: Color.black.opacity(0.15), radius: shadowRadius, x: 0, y: 2)
            .padding() // external padding
    }
}

extension View {
    fileprivate func cardStyle(cornerRadius: CGFloat = 12, shadowRadius: CGFloat = 4, backgroundColor: Color = .white) -> some View {
        self.modifier(CardModifier(cornerRadius: cornerRadius, shadowRadius: shadowRadius, backgroundColor: backgroundColor))
    }
}

#Preview {
    DashboardView()
}
