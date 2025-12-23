import Foundation
import Flux
import Dependencies
import Router
import Combine

class DashboardMiddleware {
    @Dependency(\.router) private var router
    @Dependency(\.habit) private var habitService
    
    private var cancellables = Set<AnyCancellable>()
    private var store: FluxStore<DashboardFeature>
    
    init(_ store: FluxStore<DashboardFeature>) {
        self.store = store
    }
    
    func handle() -> Middleware<DashboardFeature> {
        self.habitService.$habits
           .sink { habits in
               self.store.dispatch(.habitsLoaded(habits))
           }
           .store(in: &self.cancellables)
        
        return { state, effect in
            switch effect {
            case .loadHabits:
                let habits = await self.habitService.loadAll()
                return .habitsLoaded(habits)
                
            case .saveEntry(let entry):
                break
            }
        
            return .none
        }
    }
}
