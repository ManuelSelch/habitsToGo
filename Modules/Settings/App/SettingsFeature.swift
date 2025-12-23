import Foundation

struct SettingsFeature {
    
    enum Route: Equatable & Identifiable & Codable {
        case settings
        case logs
        
        var id: Self { self }
    }
}
