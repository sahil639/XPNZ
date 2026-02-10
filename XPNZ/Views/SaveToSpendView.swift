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

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    // Period selector
                    periodSelector
                        .padding(.horizontal, horizontalPadding)
                        .padding(.top, 20)

                    // Large centered value
                    balanceSection
                        .padding(.top, 48)

                    // Intentional empty space
                    Spacer()
                        .frame(height: 200)

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
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.primary)
                    }
                }
            }
            .overlay(alignment: .bottom) {
                // Bottom fade effect
                LinearGradient(
                    colors: [
                        Color(.systemBackground).opacity(0),
                        Color(.systemBackground).opacity(0.8),
                        Color(.systemBackground)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 100)
                .allowsHitTesting(false)
            }
        }
    }

    private var periodSelector: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(TimePeriod.allCases, id: \.self) { period in
                    Button(action: {
                        selectedPeriod = period
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
            // Large dollar amount
            Text("+$428")
                .font(.system(size: 72, weight: .bold, design: .rounded))
                .foregroundColor(.primary)

            // Percentage and description
            HStack(spacing: 4) {
                Text("+18%")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.green)

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

            VStack(spacing: 16) {
                StatRow(
                    icon: "arrow.up.circle",
                    label: "Top spending",
                    value: "$132"
                )

                StatRow(
                    icon: "arrow.down.circle",
                    label: "Top saving",
                    value: "$250"
                )

                StatRow(
                    icon: "dollarsign.circle",
                    label: "Largest expense",
                    value: "$199"
                )

                StatRow(
                    icon: "hands.sparkles",
                    label: "Best saving move",
                    value: "$48"
                )
            }
        }
    }

    private var insightsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Insights")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.primary)

            Text("You saved more than you spent today, which means your money is moving in a healthy direction. Your saving rate is stronger than your weekly average, showing consistent discipline. Small decisions compound over time.")
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
        .padding(.vertical, 4)
    }
}

#Preview {
    SaveToSpendView()
}
