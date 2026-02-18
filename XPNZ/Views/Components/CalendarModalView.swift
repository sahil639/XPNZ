import SwiftUI

/// Centered modal pop-up showing date details with spending metrics
/// Presented over home screen when tapping the calendar icon
struct CalendarModalView: View {
    @Binding var isPresented: Bool
    @State private var selectedDate: Date = Date()
    @State private var slideDirection: SlideDirection = .none
    @State private var isAnimating: Bool = false

    private let calendar = Calendar.current
    private let horizontalInset: CGFloat = 32

    enum SlideDirection {
        case left, right, none
    }

    // MARK: - Date Helpers

    private var isToday: Bool {
        calendar.isDateInToday(selectedDate)
    }

    private var monthYearString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: selectedDate)
    }

    private var dayNumber: Int {
        calendar.component(.day, from: selectedDate)
    }

    private var ordinalSuffix: String {
        let day = dayNumber
        switch day {
        case 11, 12, 13: return "th"
        default:
            switch day % 10 {
            case 1: return "st"
            case 2: return "nd"
            case 3: return "rd"
            default: return "th"
            }
        }
    }

    /// Short date label for navigation: "10 Apr"
    private func shortDateLabel(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM"
        return formatter.string(from: date)
    }

    // Mock metrics — in production these would come from a data source
    private var todaysSpending: String { "$428" }
    private var topSaving: String { "$250" }
    private var largestExpense: String { "$48" }

    // MARK: - Navigation

    private func goBack() {
        guard !isAnimating else { return }
        if let prev = calendar.date(byAdding: .day, value: -1, to: selectedDate) {
            isAnimating = true
            slideDirection = .right // content exits right, new enters from left
            withAnimation(.spring(response: 0.4, dampingFraction: 0.85)) {
                selectedDate = prev
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                isAnimating = false
            }
        }
    }

    private func goForward() {
        guard !isAnimating, !isToday else { return }
        if let next = calendar.date(byAdding: .day, value: 1, to: selectedDate) {
            isAnimating = true
            slideDirection = .left // content exits left, new enters from right
            withAnimation(.spring(response: 0.4, dampingFraction: 0.85)) {
                selectedDate = next
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                isAnimating = false
            }
        }
    }

    // MARK: - Body

    var body: some View {
        ZStack {
            // Light dim — tap to dismiss (blur applied by HomeView)
            Color.black.opacity(0.15)
                .ignoresSafeArea()
                .onTapGesture { isPresented = false }

            // Card
            VStack(spacing: 0) {
                // Header bar — month and year
                Text(monthYearString)
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Color(red: 0.88, green: 0.42, blue: 0.42)) // ⚡ EDITABLE: Header color

                // Large date display with slide animation
                dateDisplay
                    .padding(.top, 24)
                    .padding(.bottom, 20)

                // Metrics
                VStack(spacing: 0) {
                    metricRow(label: "Todays spending", value: todaysSpending)
                    metricRow(label: "Top saving", value: topSaving)
                    metricRow(label: "Largest Expense", value: largestExpense)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)

                // Date navigation
                dateNavigation
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
            }
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.horizontal, horizontalInset)
        }
    }

    // MARK: - Date Display (animated)

    private var dateDisplay: some View {
        HStack(alignment: .top, spacing: 2) {
            Text("\(dayNumber)")
                .font(.system(size: 96, weight: .black, design: .rounded))
                .foregroundColor(.primary)
                .id(dayNumber) // triggers transition on change
                .transition(.asymmetric(
                    insertion: .move(edge: slideDirection == .right ? .leading : .trailing)
                        .combined(with: .opacity),
                    removal: .move(edge: slideDirection == .right ? .trailing : .leading)
                        .combined(with: .opacity)
                ))
                .blur(radius: isAnimating ? 2 : 0) // motion blur during transition

            Text(ordinalSuffix)
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundColor(.primary)
                .padding(.top, 14)
                .id("\(dayNumber)-suffix")
                .transition(.opacity)
        }
        .animation(.spring(response: 0.4, dampingFraction: 0.85), value: selectedDate)
        .clipped()
    }

    // MARK: - Metric Row

    private func metricRow(label: String, value: String) -> some View {
        HStack {
            Text(label)
                .font(.system(size: 15, weight: .regular))
                .foregroundColor(.secondary)

            Spacer()

            Text(value)
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(.primary)
        }
        .padding(.vertical, 8)
    }

    // MARK: - Date Navigation

    private var dateNavigation: some View {
        HStack(spacing: 0) {
            // Back button
            Button(action: goBack) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.secondary)
                    .frame(width: 36, height: 36)
                    .background(Color(.systemGray6))
                    .clipShape(Circle())
            }

            // Previous day label
            if let prev = calendar.date(byAdding: .day, value: -1, to: selectedDate) {
                Text(shortDateLabel(for: prev))
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.secondary)
                    .padding(.leading, 8)
            }

            Spacer()

            // Next day label
            if let next = calendar.date(byAdding: .day, value: 1, to: selectedDate) {
                Text(shortDateLabel(for: next))
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(isToday ? .secondary.opacity(0.3) : .secondary)
                    .padding(.trailing, 8)
            }

            // Forward button — disabled if already today
            Button(action: goForward) {
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(isToday ? .secondary.opacity(0.3) : .secondary)
                    .frame(width: 36, height: 36)
                    .background(Color(.systemGray6).opacity(isToday ? 0.5 : 1))
                    .clipShape(Circle())
            }
            .disabled(isToday)
        }
    }
}

#Preview {
    CalendarModalView(isPresented: .constant(true))
}
