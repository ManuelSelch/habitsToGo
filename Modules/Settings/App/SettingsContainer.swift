import SwiftUI
import PulseUI
import Dependencies
import Router

struct SettingsContainer: View {
    let route: SettingsFeature.Route
    
    @Dependency(\.router) private var router
    
    var body: some View {
        VStack {
            switch route {
            case .settings:
                SettingsView(
                    logsTapped: { router.push(.settings(.logs)) }
                )
            case .logs:
                ConsoleView()
            }
        }
    }
}

#Preview {
    SettingsContainer(route: .settings)
}
