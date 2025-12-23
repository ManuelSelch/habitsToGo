import Foundation
import Flux

class SyncHabitMiddleware {
    func handle() -> Middleware<DashboardFeature> {
        return { state, action in
            return .none
        }
    }
}
