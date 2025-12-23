import SwiftUI
import Flux

struct HabitContainer: View {
    let route: HabitFeature.Route
    
    @StateObject private var store: FluxStore<HabitFeature> = .init(
        state: .init(),
        middlewares: [
            HabitMiddleware().handle(),
            LogMiddleware<HabitFeature>().handle()
        ]
    )
    
    var body: some View {
        VStack {
            switch route {
            case .createHabit:
                CreateHabitSheet(
                    confirmHabitTapped: { habbit in store.dispatch(.confirmHabitTapped(habbit)) }
                )
            }
        }
    }
}

#Preview {
    HabitContainer(route: .createHabit)
}
