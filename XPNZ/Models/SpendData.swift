import Foundation

/// Represents spending data for a specific time frame
struct SpendData: Identifiable {
    let id = UUID()
    let timeFrame: TimeFrame
    let amount: Double
    
    /// Formatted amount string (without currency symbol)
    var formattedAmount: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: amount)) ?? String(format: "%.2f", amount)
    }
}

/// Mock data provider for development
struct MockSpendingData {
    static let daily = SpendData(timeFrame: .day, amount: 18.75)
    static let weekly = SpendData(timeFrame: .week, amount: 143.20)
    static let monthly = SpendData(timeFrame: .month, amount: 612.90)
    static let yearly = SpendData(timeFrame: .year, amount: 7354.80)
    
    static var all: [SpendData] {
        [monthly, weekly, daily, yearly]
    }
    
    static func data(for timeFrame: TimeFrame) -> SpendData {
        switch timeFrame {
        case .day: return daily
        case .week: return weekly
        case .month: return monthly
        case .year: return yearly
        }
    }
}
