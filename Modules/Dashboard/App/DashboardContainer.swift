import SwiftUI
import Flux
import Router
import Dependencies

struct DashboardContainer: View {
    @ObservedObject private var store: FluxStore<DashboardFeature>
    
    init() {
        store = .init(
            state: .init(habits: []),
            middlewares: [
                LogMiddleware<DashboardFeature>().handle()
            ]
        )
        
        store.addMiddleware(m: DashboardMiddleware(store).handle())
    }
    
    @Dependency(\.router) private var router
    
    var body: some View {
        NavigationStack {
            DashboardView(
                habits: store.state.habits,
                habitTapped: { habbit in store.dispatch(.habitTapped(habbit)) }
            )
            .toolbar {
                Button(action: { router.showSheet(.habit(.createHabit)) }) {
                    Image(systemName: "plus")
                }
                
                Button(action: { router.push(.settings(.settings)) }) {
                    Image(systemName: "gear")
                }
            }
        }
    }
}

#Preview {
    DashboardContainer()
}
