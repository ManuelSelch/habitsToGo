import Foundation
import Flux
import Dependencies
import Router

class HabitMiddleware {
    @Dependency(\.router) var router
    @Dependency(\.habit) var habitService
    
    func handle() -> Middleware<HabitFeature> {
        return { state, effect in
            switch effect {
                
            case .saveHabit(let habit):
                await self.habitService.save(habit)
                Task { @MainActor in self.router.dismiss() }
            }
        
            return .none
        }
    }
}
