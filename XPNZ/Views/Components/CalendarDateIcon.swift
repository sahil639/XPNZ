import SwiftUI

/// Calendar-style date icon showing current month and day - rotated 8°
struct CalendarDateIcon: View {
    let date: Date
    
    private var monthAbbreviation: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter.string(from: date).uppercased()
    }
    
    private var dayNumber: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Month header (red background)
            Text(monthAbbreviation)
                .font(.system(size: 10, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .frame(width: 44, height: 14)
                .background(Color.red)
            
            // Day number (white background) - SF Rounded
            Text(dayNumber)
                .font(.system(size: 22, weight: .medium, design: .rounded))
                .foregroundColor(.black)
                .frame(width: 44, height: 32)
                .background(Color.white)
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.2), lineWidth: 0.5)
        )
        .shadow(color: .black.opacity(0.08), radius: 2, x: 0, y: 1)
        .rotationEffect(.degrees(8))
    }
}

#Preview {
    CalendarDateIcon(date: Date())
        .padding()
}
