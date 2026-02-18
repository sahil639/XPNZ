import SwiftUI

/// Represents different time periods for spending summaries
enum TimeFrame: String, CaseIterable, Identifiable {
    case day = "Day"
    case week = "Week"
    case month = "Month"
    case year = "Year"
    
    var id: String { rawValue }
    
    /// Short suffix displayed after the amount (d, w, m, y)
    var displaySuffix: String {
        switch self {
        case .day: return "d"
        case .week: return "w"
        case .month: return "m"
        case .year: return "y"
        }
    }
    
    /// Display order: Year→Month→Week→Day (lower = shown first/top)
    var displayOrder: Int {
        switch self {
        case .year: return 0
        case .month: return 1
        case .week: return 2
        case .day: return 3
        }
    }
    
    /// Font size for the amount based on hierarchy
    var fontSize: CGFloat {
        switch self {
        case .year: return 52
        case .month: return 52
        case .week: return 44
        case .day: return 40
        }
    }
    
    /// Font weight for visual hierarchy
    var fontWeight: Font.Weight {
        switch self {
        case .year: return .heavy
        case .month: return .heavy
        case .week: return .heavy
        case .day: return .heavy
        }
    }
    
    /// Base opacity for visual hierarchy (when not primary context)
    var textOpacity: Double {
        switch self {
        case .year: return 0.4
        case .month: return 0.7
        case .week: return 0.5
        case .day: return 0.4
        }
    }
    
    /// Label for time frame sheet
    var spendingLabel: String {
        "\(rawValue) Spending"
    }
}
