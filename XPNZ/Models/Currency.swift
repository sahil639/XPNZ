import Foundation

/// Currency representation for future multi-currency support
enum Currency: String, CaseIterable, Identifiable {
    case usd = "USD"
    
    var id: String { rawValue }
    
    /// Currency symbol
    var symbol: String {
        switch self {
        case .usd: return "$"
        }
    }
    
    /// Format an amount with this currency
    func format(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        let formattedAmount = formatter.string(from: NSNumber(value: amount)) ?? String(format: "%.2f", amount)
        return "\(symbol)\(formattedAmount)"
    }
}

/// Global currency setting (can be made observable for future switching)
struct CurrencySettings {
    static var current: Currency = .usd
}
