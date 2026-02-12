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

    // Random values for each period
    private var balanceData: (amount: String, percentage: String, isPositive: Bool) {
        switch selectedPeriod {
        case .today:
            return ("+$428", "+18%", true)
        case .weekly:
            return ("-$85", "-5%", false)
        case .monthly:
            return ("+$1,247", "+23%", true)
        case .yearly:
            return ("+$8,935", "+42%", true)
        case .custom:
            return ("-$312", "-12%", false)
        }
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

                // Large centered value
                balanceSection
                    .padding(.top, 48)

                // Lever track
                LeverTrackView()
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

    private var balanceSection: some View {
        VStack(spacing: 8) {
            // Large dollar amount (reduced by 10%)
            Text(balanceData.amount)
                .font(.system(size: 65, weight: .bold, design: .rounded))
                .foregroundColor(.primary)

            // Percentage and description
            HStack(spacing: 4) {
                Text(balanceData.percentage)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(balanceData.isPositive ? .green : .red)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .fill(balanceData.isPositive ? Color.green.opacity(0.15) : Color.red.opacity(0.15))
                    )

                Text("toward saving")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity)
    }

    private var whatShapedSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("What shaped your balance")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.primary)
                .padding(.bottom, 4)

            VStack(spacing: 0) {
                StatRow(
                    icon: "arrow.up.circle",
                    label: "Top spending",
                    value: "$132",
                    hasBackground: true
                )

                StatRow(
                    icon: "arrow.down.circle",
                    label: "Top saving",
                    value: "$250",
                    hasBackground: false
                )

                StatRow(
                    icon: "dollarsign.circle",
                    label: "Largest expense",
                    value: "$199",
                    hasBackground: true
                )

                StatRow(
                    icon: "hands.sparkles",
                    label: "Best saving move",
                    value: "$48",
                    hasBackground: false
                )
            }
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
        .background(hasBackground ? Color(.systemGray6) : Color.clear)
    }
}

#Preview {
    NavigationStack {
        SaveToSpendView()
    }
}
