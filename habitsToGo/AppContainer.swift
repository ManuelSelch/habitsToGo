import SwiftUI
import Flux
import Router
import Dependencies

struct AppContainer: View {
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
                        DashboardContainer()
                    case let .habit(route):
                        HabitContainer(route: route)
                    case let .settings(route):
                        SettingsContainer(route: route)
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
