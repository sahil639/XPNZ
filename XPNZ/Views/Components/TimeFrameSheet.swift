import SwiftUI

/// Bottom sheet for toggling time frame visibility with blur background
struct TimeFrameSheet: View {
    @Binding var enabledTimeFrames: Set<TimeFrame>
    @Environment(\.dismiss) private var dismiss
    
    // Order: Year, Month, Week, Day
    private let orderedTimeFrames: [TimeFrame] = [.year, .month, .week, .day]
    
    var body: some View {
        VStack(spacing: 0) {
            // Title
            Text("Time Frames")
                .font(.system(size: 17, weight: .semibold, design: .rounded))
                .padding(.top, 20)
                .padding(.bottom, 16)
            
            // Toggles
            VStack(spacing: 0) {
                ForEach(orderedTimeFrames) { timeFrame in
                    VStack(spacing: 0) {
                        HStack {
                            Text(timeFrame.spendingLabel)
                                .font(.system(size: 17, weight: .medium, design: .rounded))
                                .foregroundColor(.primary)
                            
                            Spacer()
                            
                            Toggle("", isOn: binding(for: timeFrame))
                                .labelsHidden()
                                .tint(.blue)
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 14)
                        
                        if timeFrame != .day {
                            Divider()
                                .padding(.leading, 20)
                        }
                    }
                }
            }
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal, 16)
            
            Spacer()
        }
        .background(Color(.systemGray6))
        .presentationDetents([.medium])
        .presentationDragIndicator(.visible)
        .presentationBackground(.ultraThinMaterial)
    }
    
    private func binding(for timeFrame: TimeFrame) -> Binding<Bool> {
        Binding(
            get: { enabledTimeFrames.contains(timeFrame) },
            set: { isEnabled in
                if isEnabled {
                    enabledTimeFrames.insert(timeFrame)
                } else {
                    enabledTimeFrames.remove(timeFrame)
                }
            }
        )
    }
}

#Preview {
    TimeFrameSheet(enabledTimeFrames: .constant([.day, .week, .month]))
}
