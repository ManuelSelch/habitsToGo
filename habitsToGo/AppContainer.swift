import SwiftUI
import Flux
import Router
import Dependencies

struct AppContainer: View {
    let dashboard = FluxStore<DashboardFeature>(
        state: .init(),
        middlewares: [
            SyncHabitMiddleware().handle()
        ]
    )
    
    @Dependency(\.router) var router
    
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
                    case let .habit(route):
                        HabitContainer(route: route)
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
