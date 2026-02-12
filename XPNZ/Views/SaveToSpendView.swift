import SwiftUI

/// Save-to-Spend screen showing daily net balance and insights
struct SaveToSpendView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedPeriod: TimePeriod = .today

    private let horizontalPadding: CGFloat = 20

    enum TimePeriod: String, CaseIterable {
        case today = "Today"
        case weekly = "Weekly"
        case monthly = "Monthly"
        case yearly = "Yearly"
        case custom = "Custom"
    }

    // Random values for each period — rawPercent is -100 (all spend) to +100 (all save)
    private var balanceData: (amount: String, percentage: String, isPositive: Bool, rawPercent: CGFloat) {
        switch selectedPeriod {
        case .today:
            return ("+$428", "+18%", true, 18)
        case .weekly:
            return ("-$85", "-5%", false, -5)
        case .monthly:
            return ("+$1,247", "+23%", true, 23)
        case .yearly:
            return ("+$8,935", "+42%", true, 42)
        case .custom:
            return ("-$312", "-12%", false, -12)
        }
    }

    /// Bubble position: 0.0 = fully Spend (left), 1.0 = fully Save (right)
    /// Maps rawPercent (-100...+100) to 0...1 range, with 0% at center (0.5)
    private var bubblePosition: CGFloat {
        let clamped = min(max(balanceData.rawPercent, -100), 100)
        return (clamped + 100) / 200 // ⚡ EDITABLE: Position mapping formula
    }

    private var insightText: String {
        if balanceData.isPositive {
            return "You saved more than you spent today, which means your money is moving in a healthy direction. Your saving rate is stronger than your weekly average, showing consistent discipline. Small decisions compound over time."
        } else {
            return "You spent more than you saved this period. Consider reviewing your top expenses and identifying areas where you can reduce spending. Small adjustments in daily habits can lead to significant improvements over time."
        }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // Period selector
                periodSelector
                    .padding(.horizontal, horizontalPadding)
                    .padding(.top, 20)

                // Large centered value (odometer animation)
                OdometerBalanceView(
                    amount: balanceData.amount,
                    percentage: balanceData.percentage,
                    isPositive: balanceData.isPositive,
                    description: "toward saving"
                )
                    .padding(.top, 48)

                // Lever track with bubble positioned by save/spend ratio
                LeverTrackView(bubblePosition: bubblePosition)
                    .padding(.horizontal, 40)
                    .padding(.top, 48)
                    .padding(.bottom, 48)

                // What shaped your balance
                whatShapedSection
                    .padding(.horizontal, horizontalPadding)

                // Insights section
                insightsSection
                    .padding(.horizontal, horizontalPadding)
                    .padding(.top, 48)
                    .padding(.bottom, 80)
            }
        }
        .background(Color(.systemBackground))
        .navigationTitle("Save-to-Spend")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.primary)
                }
            }
        }
    }

    private var periodSelector: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(TimePeriod.allCases, id: \.self) { period in
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            selectedPeriod = period
                        }
                    }) {
                        Text(period.rawValue)
                            .font(.system(size: 15, weight: selectedPeriod == period ? .medium : .regular))
                            .foregroundColor(selectedPeriod == period ? .primary : .secondary)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(
                                Capsule()
                                    .fill(selectedPeriod == period ? Color(.systemGray5) : Color.clear)
                            )
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    private var whatShapedSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("What shaped your balance")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.primary)
                .padding(.bottom, 4)

            VStack(spacing: 2) { // ⚡ EDITABLE: Gap between rounded stat rows
                StatRow(
                    icon: "arrow.up.circle",
                    label: "Top spending",
                    value: "$132",
                    hasBackground: true,
                    position: .top
                )

                StatRow(
                    icon: "arrow.down.circle",
                    label: "Top saving",
                    value: "$250",
                    hasBackground: false,
                    position: .middle
                )

                StatRow(
                    icon: "dollarsign.circle",
                    label: "Largest expense",
                    value: "$199",
                    hasBackground: true,
                    position: .middle
                )

                StatRow(
                    icon: "hands.sparkles",
                    label: "Best saving move",
                    value: "$48",
                    hasBackground: false,
                    position: .bottom
                )
            }
            .clipShape(RoundedRectangle(cornerRadius: 12)) // ⚡ EDITABLE: Overall list corner radius
        }
    }

    private var insightsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Insights")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.black)

            Text(insightText)
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(.secondary)
                .lineSpacing(4)
        }
    }
}

/// Single stat row with icon, label, and value
struct StatRow: View {
    let icon: String
    let label: String
    let value: String
    let hasBackground: Bool
    var position: RowPosition = .middle // ⚡ EDITABLE: Row position for corner rounding

    enum RowPosition {
        case top, middle, bottom, alone
    }

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 20, weight: .regular))
                .foregroundColor(.secondary)
                .frame(width: 24)

            Text(label)
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(.secondary)

            Spacer()

            Text(value)
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(.primary)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(hasBackground ? Color(.systemGray6) : Color(.systemBackground))
    }
}

#Preview {
    NavigationStack {
        SaveToSpendView()
    }
}
