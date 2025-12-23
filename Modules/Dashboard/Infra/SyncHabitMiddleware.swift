import Foundation
import Flux
import Dependencies
import Router

class SyncHabitMiddleware {
    @Dependency(\.router) var router
    
    func handle() -> Middleware<DashboardFeature> {
        return { state, effect in
            switch effect {
            case .showCreateHabitSheet:
                Task { @MainActor in self.router.showSheet(.habit(.createHabit)) }
               
            case .saveHabit(let habit):
                // todo: validate & store
                Task { @MainActor in self.router.dismiss() }
                return .habitCreated(habit)
            }
        
            return .none
        }
    }
}
