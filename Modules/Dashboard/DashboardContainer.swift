import SwiftUI
import Flux

struct DashboardContainer: View {
    @ObservedObject var store: FluxStore<DashboardFeature>
    
    var body: some View {
        NavigationStack {
            DashboardView(
                habits: store.state.habits,
                habitTapped: { habbit in store.dispatch(.habitTapped(habbit)) }
            )
            .toolbar {
                Button(action: { store.dispatch(.createHabitTapped) }) {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    DashboardContainer(
        store: .init(state: .init(habits: Habit.sample))
    )
}
