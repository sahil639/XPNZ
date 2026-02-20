import SwiftUI

/// Header icons replacing the Add Time Frame button
struct HeaderIconsView: View {
    let onBandageTap: () -> Void
    let onTimeFrameTap: () -> Void

    var body: some View {
        HStack(spacing: 16) {
            // Bandage icon - opens Save-to-Spend
            Button(action: onBandageTap) {
                Image(systemName: "bandage")
                    .font(.system(size: 28
                                  
                                  , weight: .medium))
                    .foregroundColor(Color(.systemGray))
            }
            .buttonStyle(.plain)

            // Clock/time frame icon
            Button(action: onTimeFrameTap) {
                Image(systemName: "clock.arrow.trianglehead.counterclockwise.rotate.90")
                    .font(.system(size: 28, weight: .medium))
                    .foregroundColor(Color(.systemGray))
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    HeaderIconsView(onBandageTap: {}, onTimeFrameTap: {})
        .padding()
}
