import Foundation
import Flux
import Pulse
import Dependencies

struct LogService {
    let logger = LoggerStore.shared
    
    func debug(_ msg: String, for label: String) {
        LoggerStore.shared.storeMessage(
            label: label,
            level: .debug,
            message: msg
        )
    }
}

struct LogServiceKey: DependencyKey {
    static let liveValue = LogService()
    static let mockValue = liveValue
}

extension DependencyValues {
    var logger: LogService {
        Self[LogServiceKey.self]
    }
}
