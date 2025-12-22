import SwiftUI
import Flux
import Router

struct AppContainer: View {
    let dashboard = FluxStore<DashboardFeature>(
        state: .init(),
        middlewares: [
            SyncHabitMiddleware().handle()
        ]
    )
    
    @ObservedObject var router = MyRouter.shared
    
    var body: some View {
        AppRouterView(
            router: router,
            header: { EmptyView() },
            content: { route in
                ZStack {
                    Color.background.ignoresSafeArea()
                    
                    switch(route) {
                    case .dashboard:
                        DashboardContainer(store: dashboard)
                    case .createHabitSheet:
                        CreateHabitSheet(
                            createHabitTapped: { habit in dashboard.dispatch(.habitCreated(habit)) }
                        )
                    }
                    
                }
            },
            label: { _ in EmptyView() }
        )
        
        
    }
}

#Preview {
    AppContainer()
}
