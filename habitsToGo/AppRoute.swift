import Foundation
import Router
import Dependencies

nonisolated enum Route: Equatable & Hashable & Identifiable & Codable {
    case dashboard
    case habit(HabitFeature.Route)
    case settings(SettingsFeature.Route)
    
    var id: Self { self }
}

nonisolated enum TabRoute: Equatable & Hashable & Codable & Identifiable & CaseIterable {
    case home
    
    var id: Self { self }
}

typealias MyRouter = AppRouter<Route, TabRoute>

struct MyRouterKey: DependencyKey {
    static var liveValue = MyRouter(tab: .home, routers: [
        .home: StackRouter(root: .dashboard)
    ])
    
    static var mockValue = liveValue
}

extension DependencyValues {
    var router: MyRouter {
        get { Self[MyRouterKey.self] }
    }
}
