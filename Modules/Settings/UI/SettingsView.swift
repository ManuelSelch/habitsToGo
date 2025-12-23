import SwiftUI

struct SettingsView: View {
    let logsTapped: () -> Void
    
    var body: some View {
        VStack {
            Text("Settings")
            
            List {
                Button("Logs", action: logsTapped)
            }
            .tint(Color.contrast)
        }
    }
}

#Preview {
    SettingsView(
        logsTapped: {}
    )
}
