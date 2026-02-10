import Foundation

/// Represents a transaction category for filtering
enum TransactionCategory: String, CaseIterable, Identifiable {
    case all = "All"
    case byCategory = "By Category"
    case topSpends = "Top Spends"
    case byDay = "By Day"
    case recurring = "Recurring"
    
    var id: String { rawValue }
}

/// Represents a transaction type
enum TransactionType: String {
    case moneyTransfer = "Money Transfer"
    case card = "Card"
    case moneyAdded = "Money added"
    case subscription = "Subscription"
    case purchase = "Purchase"
}

/// Represents a single transaction
struct Transaction: Identifiable {
    let id = UUID()
    let name: String
    let type: TransactionType
    let amount: Double
    let isIncoming: Bool
    let iconName: String
    
    /// Formatted amount with sign
    var formattedAmount: String {
        let prefix = isIncoming ? "" : ""
        return "\(prefix)$\(String(format: "%.0f", abs(amount)))"
    }
}

/// Mock transaction data provider
struct MockTransactions {
    
    static let monthlyTransactions: [Transaction] = [
        Transaction(name: "From Ale Gonzales", type: .moneyTransfer, amount: 1000, isIncoming: true, iconName: "arrow.up.circle"),
        Transaction(name: "From Ale Gonzales", type: .moneyTransfer, amount: 2000, isIncoming: true, iconName: "arrow.up.circle"),
        Transaction(name: "To Ale Gonzales", type: .moneyTransfer, amount: 240, isIncoming: false, iconName: "paperplane"),
        Transaction(name: "Wallgreens", type: .card, amount: 13.80, isIncoming: false, iconName: "creditcard"),
        Transaction(name: "CITIZE CK WEBXFR", type: .moneyAdded, amount: 1000, isIncoming: true, iconName: "arrow.down.circle"),
        Transaction(name: "Netflix", type: .subscription, amount: 15.99, isIncoming: false, iconName: "play.rectangle"),
        Transaction(name: "Spotify", type: .subscription, amount: 9.99, isIncoming: false, iconName: "music.note"),
        Transaction(name: "Amazon", type: .purchase, amount: 89.50, isIncoming: false, iconName: "bag"),
        Transaction(name: "Target", type: .card, amount: 156.32, isIncoming: false, iconName: "creditcard"),
        Transaction(name: "From John Smith", type: .moneyTransfer, amount: 500, isIncoming: true, iconName: "arrow.up.circle"),
    ]
    
    static let weeklyTransactions: [Transaction] = [
        Transaction(name: "Starbucks", type: .card, amount: 6.50, isIncoming: false, iconName: "cup.and.saucer"),
        Transaction(name: "Uber", type: .card, amount: 24.80, isIncoming: false, iconName: "car"),
        Transaction(name: "From Mom", type: .moneyTransfer, amount: 100, isIncoming: true, iconName: "arrow.up.circle"),
        Transaction(name: "Whole Foods", type: .card, amount: 78.45, isIncoming: false, iconName: "cart"),
        Transaction(name: "Gas Station", type: .card, amount: 45.00, isIncoming: false, iconName: "fuelpump"),
    ]
    
    static let dailyTransactions: [Transaction] = [
        Transaction(name: "Coffee Shop", type: .card, amount: 5.25, isIncoming: false, iconName: "cup.and.saucer"),
        Transaction(name: "Lunch", type: .card, amount: 13.50, isIncoming: false, iconName: "fork.knife"),
    ]
    
    static let yearlyTransactions: [Transaction] = [
        Transaction(name: "Salary Deposit", type: .moneyAdded, amount: 45000, isIncoming: true, iconName: "building.columns"),
        Transaction(name: "Rent Payments", type: .moneyTransfer, amount: 24000, isIncoming: false, iconName: "house"),
        Transaction(name: "Insurance", type: .subscription, amount: 2400, isIncoming: false, iconName: "shield"),
        Transaction(name: "Investments", type: .moneyTransfer, amount: 12000, isIncoming: false, iconName: "chart.line.uptrend.xyaxis"),
    ]
    
    static func transactions(for timeFrame: TimeFrame) -> [Transaction] {
        switch timeFrame {
        case .day: return dailyTransactions
        case .week: return weeklyTransactions
        case .month: return monthlyTransactions
        case .year: return yearlyTransactions
        }
    }
}
