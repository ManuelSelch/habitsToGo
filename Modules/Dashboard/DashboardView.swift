import SwiftUI

struct DashboardView: View {
    let layout = [
        GridItem(.flexible(minimum: 50, maximum: .infinity)),
        GridItem(.flexible(minimum: 50, maximum: .infinity)),
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: layout) {
                HabitCard("Reading")
                HabitCard("Coding")
                HabitCard("Swimming")
                HabitCard("Sleeping")
            }
        }
        .padding()
    }
}

@ViewBuilder
func HabitCard(_ name: String) -> some View {
    ZStack {
        Circle()
            .fill(Color.theme)
        
        VStack(spacing: 10) {
            Image(systemName: "person.fill")
            Text(name)
        }
        .font(.system(size: 16, weight: .heavy))
        .foregroundStyle(Color.white)
    }
    .padding()
}

#Preview {
    DashboardView()
}
