import Foundation
import Flux

struct HabitFeature {
    
    enum Route: Equatable & Hashable & Identifiable & Codable {
        case createHabit
        
        var id: Self { self }
    }
}
