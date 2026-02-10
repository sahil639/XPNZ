import SwiftUI

/// Rounded pill-style button for adding time frames
struct AddTimeFrameButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 4) {
                Text("+")
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                Text("Add Time Frame")
                    .font(.system(size: 13, weight: .medium, design: .rounded))
            }
            .foregroundColor(.primary)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                Capsule()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    AddTimeFrameButton(action: {})
        .padding()
}
