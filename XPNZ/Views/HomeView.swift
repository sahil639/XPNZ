import SwiftUI

/// Main home screen displaying spend summaries with expandable dropdowns
struct HomeView: View {
    // MARK: - State
    
    /// Currently enabled time frames (Day, Week, Month enabled by default)
    @State private var enabledTimeFrames: Set<TimeFrame> = [.day, .week, .month]
    
    /// Currently expanded time frame (only one at a time) - tap same to close
    @State private var expandedTimeFrame: TimeFrame? = nil
    
    /// Controls the time frame selection sheet
    @State private var showingTimeFrameSheet = false

    /// Controls navigation to Save-to-Spend screen
    @State private var showingSaveToSpend = false

    /// Controls calendar modal pop-up
    @State private var showingCalendarModal = false

    /// FAB color cycle index (0 = default, 1-6 = colors)
    @State private var colorCycleIndex = 0

    private let bgColors: [Color] = [
        Color(red: 0.2, green: 0.7, blue: 0.2),     // green
        Color(red: 1.0, green: 0.55, blue: 0.25),    // papaya orange
        Color(red: 0.9, green: 0.75, blue: 0.0),     // deep yellow
        Color(red: 0.15, green: 0.2, blue: 0.55),    // dark blue
        Color(red: 0.5, green: 0.2, blue: 0.6),      // purple
        Color(red: 1.0, green: 0.25, blue: 0.5),     // hot pink
    ]

    private var isColorMode: Bool { colorCycleIndex > 0 }
    private var currentBgColor: Color {
        isColorMode ? bgColors[colorCycleIndex - 1] : Color(.systemBackground)
    }

    /// Current currency (structured for future switching)
    private let currency: Currency = CurrencySettings.current
    
    /// Spring animation for expand/collapse
    private let springAnimation = Animation.spring(response: 0.45, dampingFraction: 0.75, blendDuration: 0)
    
    /// Standard horizontal padding for iOS
    private let horizontalPadding: CGFloat = 20
    
    // MARK: - Computed Properties
    
    /// Spend data sorted by display order (Year→Month→Week→Day), filtered by enabled
    private var visibleSpendData: [SpendData] {
        enabledTimeFrames
            .map { MockSpendingData.data(for: $0) }
            .sorted { $0.timeFrame.displayOrder < $1.timeFrame.displayOrder }
    }
    
    /// Currently expanded spend data
    private var expandedSpendData: SpendData? {
        guard let timeFrame = expandedTimeFrame else { return nil }
        return MockSpendingData.data(for: timeFrame)
    }
    
    /// Whether Year is enabled and not the currently expanded one (de-emphasize)
    private func isYearPrimaryContext(for timeFrame: TimeFrame) -> Bool {
        if timeFrame == .year {
            // Year is primary when it's enabled and nothing else is expanded, or Year itself is expanded
            return expandedTimeFrame == nil || expandedTimeFrame == .year
        }
        return false
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                // Main content
                mainContent
                    .blur(radius: (showingTimeFrameSheet || showingCalendarModal) ? 3 : 0)

                // FAB — profile button (cycles through colors)
                Button {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        colorCycleIndex = (colorCycleIndex + 1) % (bgColors.count + 1)
                    }
                } label: {
                    Image(systemName: "person.crop.circle")
                        .font(.system(size: 28))
                        .foregroundColor(isColorMode ? .white : Color(.darkGray))
                        .frame(width: 52, height: 52)
                        .glassEffect(.clear, in: Circle())
                }
                .padding(.trailing, 20)
                .padding(.bottom, 32)
            }
            .background(currentBgColor)
            .navigationDestination(isPresented: $showingSaveToSpend) {
                SaveToSpendView()
            }
            .sheet(isPresented: $showingTimeFrameSheet) {
                TimeFrameSheet(enabledTimeFrames: $enabledTimeFrames)
            }
            .overlay {
                if showingCalendarModal {
                    CalendarModalView(isPresented: $showingCalendarModal)
                        .transition(.opacity)
                }
            }
            .animation(.easeInOut(duration: 0.25), value: showingCalendarModal)
        }
    }
    
    private var mainContent: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Header
            headerView
                .padding(.horizontal, horizontalPadding)
                .padding(.top, 16)
                .padding(.bottom, 24)
            
            // Spend values with expandable popup
            spendValuesSection
                .padding(.horizontal, horizontalPadding)
            
            Spacer()
        }
    }
    
    // MARK: - Subviews
    
    private var headerView: some View {
        HStack {
            Button {
                showingCalendarModal.toggle()
            } label: {
                CalendarDateIcon(date: Date())
            }

            Spacer()

            HeaderIconsView(
                onBandageTap: {
                    showingSaveToSpend = true
                },
                onTimeFrameTap: {
                    showingTimeFrameSheet = true
                }
            )
        }
    }
    
    private var spendValuesSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            ForEach(visibleSpendData) { spendData in
                if expandedTimeFrame == spendData.timeFrame {
                    // Expanded card with consistent padding
                    ExpandedSpendCard(
                        spendData: spendData,
                        currency: currency,
                        onClose: {
                            withAnimation(springAnimation) {
                                expandedTimeFrame = nil
                            }
                        }
                    )
                    .transition(.asymmetric(
                        insertion: .opacity.combined(with: .scale(scale: 0.98)),
                        removal: .opacity
                    ))
                } else {
                    // Non-expanded row - tappable to toggle
                    SpendValueRow(
                        spendData: spendData,
                        currency: currency,
                        isExpanded: false,
                        isDimmed: expandedTimeFrame != nil,
                        isPrimaryContext: isYearPrimaryContext(for: spendData.timeFrame),
                        textColor: isColorMode ? .white : .primary,
                        onTap: {
                            withAnimation(springAnimation) {
                                if expandedTimeFrame == spendData.timeFrame {
                                    // Close if same value tapped
                                    expandedTimeFrame = nil
                                } else {
                                    // Open this value (closes any other)
                                    expandedTimeFrame = spendData.timeFrame
                                }
                            }
                        }
                    )
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
