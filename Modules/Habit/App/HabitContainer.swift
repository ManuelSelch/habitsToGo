import SwiftUI

struct HabitContainer: View {
    
    let route: HabitFeature.Route
    
    var body: some View {
        VStack {
            switch route {
            case .createHabit:
                CreateHabitSheet(
                    confirmHabitTapped: { _ in }
                )
            }
        }
    }
}

#Preview {
    HabitContainer(route: .createHabit)
}
