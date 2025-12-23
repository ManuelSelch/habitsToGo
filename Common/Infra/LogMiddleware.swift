import Foundation
import Flux
import Pulse
import Dependencies

struct LogMiddleware<F: Feature> {
    @Dependency(\.logger) private var logger
    
    func handle() -> Middleware<F> {
        return { state, effect in
            
            await logger.debug("\(effect)", for: "\(F.self)")
            
            return .none
        }
    }
}
