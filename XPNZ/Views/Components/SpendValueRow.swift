import SwiftUI

/// Displays a spend value with currency symbol and time frame suffix
/// Tappable to expand and show transaction details
struct SpendValueRow: View {
    let spendData: SpendData
    let currency: Currency
    let isExpanded: Bool
    let isDimmed: Bool
    let isPrimaryContext: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack(alignment: .firstTextBaseline, spacing: 0) {
                // Currency symbol (smaller, lighter)
                Text(currency.symbol)
                    .font(.system(size: spendData.timeFrame.fontSize * 0.5, weight: .semibold, design: .rounded))
                    .foregroundColor(.primary.opacity(effectiveOpacity * 0.7))
                
                // Amount
                Text(spendData.formattedAmount)
                    .font(.system(size: spendData.timeFrame.fontSize, weight: spendData.timeFrame.fontWeight, design: .rounded))
                    .foregroundColor(.primary.opacity(effectiveOpacity))
                
                // Time frame suffix (smaller, lighter)
                Text(spendData.timeFrame.displaySuffix)
                    .font(.system(size: spendData.timeFrame.fontSize * 0.5, weight: .semibold, design: .rounded))
                    .foregroundColor(.primary.opacity(effectiveOpacity * 0.6))
            }
        }
        .buttonStyle(.plain)
        .opacity(isDimmed ? 0.35 : 1.0)
    }
    
    private var effectiveOpacity: Double {
        // Year: darker when primary context, lighter when not focused
        if spendData.timeFrame == .year {
            return isPrimaryContext ? 0.8 : 0.35
        }
        return spendData.timeFrame.textOpacity
    }
}

#Preview {
    VStack(alignment: .leading, spacing: 20) {
        SpendValueRow(
            spendData: MockSpendingData.yearly,
            currency: .usd,
            isExpanded: false,
            isDimmed: false,
            isPrimaryContext: true,
            onTap: {}
        )
        SpendValueRow(
            spendData: MockSpendingData.monthly,
            currency: .usd,
            isExpanded: false,
            isDimmed: false,
            isPrimaryContext: false,
            onTap: {}
        )
        SpendValueRow(
            spendData: MockSpendingData.weekly,
            currency: .usd,
            isExpanded: false,
            isDimmed: true,
            isPrimaryContext: false,
            onTap: {}
        )
    }
    .padding()
}
