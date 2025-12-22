import SwiftUI

struct AppContainer: View {
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            DashboardView()
        }
        
    }
}

#Preview {
    AppContainer()
}
