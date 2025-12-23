import Foundation

/// defines how long a goal takes
nonisolated enum TrackingPeriod: Hashable, Codable {
    case day(DateComponents)
    case week(year: Int, weekOfYear: Int)
    case month(year: Int, month: Int)
}

nonisolated extension TrackingPeriod {
    static func today() -> Self {
        let c = Calendar.current.dateComponents([.year, .month, .day], from: .now)
        return .day(c)
    }

    static func currentWeek() -> Self {
        let c = Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: .now)
        return .week(year: c.yearForWeekOfYear!, weekOfYear: c.weekOfYear!)
    }
}
