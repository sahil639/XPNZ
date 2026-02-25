import SwiftUI

/// Bottom navigation bar with glass pill + circular FAB
struct BottomNavBar: View {
    let isColorMode: Bool
    let onHomeTap: () -> Void
    let onSpendTap: () -> Void
    let onSaveTap: () -> Void
    let onAnalyticsTap: () -> Void
    let onFabTap: () -> Void

    var body: some View {
        HStack(spacing: 4 ) {
            // Glass pill with 4 icon buttons
            HStack(spacing: 0) {
                navButton(icon: "house.fill", action: onHomeTap)
                navButton(icon: "creditcard.fill", action: onSpendTap)
                navButton(icon: "banknote.fill", action: onSaveTap)
                navButton(icon: "chart.bar.fill", action: onAnalyticsTap)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 8)
            .glassEffect(.clear, in: Capsule())

            // FAB — color cycle button
            Button(action: onFabTap) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(isColorMode ? .white : .primary)
                    .frame(width: 52, height: 52)
                    .glassEffect(.clear, in: Circle())
            }
        }
        .padding(.horizontal, 8)
        .padding(.bottom, 8)
    }

    private func navButton(icon: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(isColorMode ? .white : .primary)
                .frame(maxWidth: .infinity)
                .frame(height: 52)
        }
    }
}

#Preview {
    VStack {
        Spacer()
        BottomNavBar(
            isColorMode: false,
            onHomeTap: {},
            onSpendTap: {},
            onSaveTap: {},
            onAnalyticsTap: {},
            onFabTap: {}
        )
    }
}
