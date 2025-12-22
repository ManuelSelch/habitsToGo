import Foundation
import Router

enum Route: Equatable & Hashable & Identifiable & Codable {
    case dashboard
    case createHabitSheet
    
    var id: Self { self }
}

enum TabRoute: Equatable & Hashable & Codable & Identifiable & CaseIterable {
    case home
    
    var id: Self { self }
}

// typealias MyRouter = StackRouter<Route>

@MainActor
struct MyRouter {
    static let shared = AppRouter<Route, TabRoute>(tab: .home, routers: [
        .home: StackRouter(root: .dashboard)
    ])
}
