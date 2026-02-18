import SwiftUI

/// Centered modal pop-up showing date details with spending metrics
/// Presented over Save-to-Spend screen when tapping the calendar icon
struct CalendarModalView: View {
    @Binding var isPresented: Bool
    @State private var selectedDate: Date = Date()

    private let calendar = Calendar.current
    private let horizontalInset: CGFloat = 32

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

    private func dateLabel(for date: Date) -> String {
        let day = calendar.component(.day, from: date)
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        let month = formatter.string(from: date)
        let suffix: String = {
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
        }()
        return "\(day)\(suffix) \(month)"
    }

    // Mock metrics — in production these would come from a data source
    private var todaysSpending: String { "$428" }
    private var topSaving: String { "$250" }
    private var largestExpense: String { "$48" }

    // MARK: - Body

    var body: some View {
        ZStack {
            // Dimmed blurred background — tap to dismiss
            Color.black.opacity(0.3)
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

                // Large date display
                VStack(spacing: 0) {
                    HStack(alignment: .top, spacing: 2) {
                        Text("\(dayNumber)")
                            .font(.system(size: 96, weight: .black, design: .rounded))
                            .foregroundColor(.primary)

                        Text(ordinalSuffix)
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            .foregroundColor(.primary)
                            .padding(.top, 14)
                    }
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
                }

                // Date navigation
                dateNavigation
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
            }
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.horizontal, horizontalInset)
        }
        .background(BackdropBlurView().ignoresSafeArea()) // Native blur behind overlay
        .animation(.easeInOut(duration: 0.25), value: selectedDate)
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
        HStack(spacing: 12) {
            // Back button
            Button {
                if let prev = calendar.date(byAdding: .day, value: -1, to: selectedDate) {
                    selectedDate = prev
                }
            } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.secondary)
                    .frame(width: 36, height: 36)
                    .background(Color(.systemGray6))
                    .clipShape(Circle())
            }

            // Previous day label
            if let prev = calendar.date(byAdding: .day, value: -1, to: selectedDate) {
                Text(dateLabel(for: prev))
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.secondary)
            }

            Spacer()

            // Next day label
            if let next = calendar.date(byAdding: .day, value: 1, to: selectedDate) {
                Text(dateLabel(for: next))
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(isToday ? .secondary.opacity(0.3) : .secondary)
            }

            // Forward button — disabled if already today
            Button {
                if !isToday, let next = calendar.date(byAdding: .day, value: 1, to: selectedDate) {
                    selectedDate = next
                }
            } label: {
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

/// UIViewRepresentable that applies a native UIVisualEffectView blur behind the modal
private struct BackdropBlurView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterial))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

#Preview {
    CalendarModalView(isPresented: .constant(true))
}
