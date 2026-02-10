# XPNZ

A modern iOS finance app built with SwiftUI for tracking spending and saving habits with elegant visualizations and insights.

## 📱 Features

### Home Screen
- **Expandable Spend Summaries**: View spending across multiple time frames (Day, Week, Month, Year)
- **Tap-to-Expand Cards**: Interactive cards that expand to show detailed transaction breakdowns
- **Category Filtering**: Filter transactions by category (All, By Category, Top Spends, By Day, Recurring)
- **Real-time Updates**: Animated transitions and smooth spring animations
- **Rotated Calendar Icon**: Playful 8° tilted calendar showing current date
- **Time Frame Selection**: Customize which time frames are visible via sheet modal

### Save-to-Spend Screen
- **Net Balance Tracking**: See daily/weekly/monthly/yearly save-to-spend balance
- **Percentage Indicators**: Visual feedback on saving progress with color-coded percentages
- **Balance Insights**: Four key metrics showing what shaped your balance:
  - Top spending
  - Top saving
  - Largest expense
  - Best saving move
- **AI-like Insights**: Contextual paragraph explaining spending/saving behavior
- **Period Selector**: Horizontal scrollable toggle for Today/Weekly/Monthly/Yearly/Custom views
- **Bottom Fade Effect**: Elegant progressive blur for content overflow

### Transaction Management
- **Transaction List**: Clean, organized view of all transactions
- **Category Icons**: SF Symbols representing different transaction types
- **Transaction Details**: Date, merchant, category, and amount for each transaction
- **Category Tabs**: Quick filtering by transaction category

### Design System
- **iOS Native Patterns**: Follows Apple Human Interface Guidelines
- **Semantic Colors**: Automatic light/dark mode support
- **SF Pro Rounded Typography**: Clean, modern font hierarchy
- **Standard Spacing**: 20pt horizontal padding throughout
- **Spring Animations**: Natural, responsive feel with spring(response: 0.45, dampingFraction: 0.75)
- **No Shadows**: Clean, flat aesthetic for modern iOS 17+ feel

## 🏗️ Architecture

### Project Structure

```
XPNZ/
├── Models/
│   ├── TimeFrame.swift          # Time period enums (Day, Week, Month, Year)
│   ├── SpendData.swift          # Spending data model
│   ├── Currency.swift           # Currency model (USD, EUR, etc.)
│   └── Transaction.swift        # Transaction model with categories
├── Views/
│   ├── HomeView.swift           # Main home screen with expandable cards
│   ├── SaveToSpendView.swift   # Save-to-Spend insights screen
│   └── Components/
│       ├── CalendarDateIcon.swift      # Rotated calendar date icon
│       ├── HeaderIconsView.swift       # Top right header icons
│       ├── SpendValueRow.swift         # Collapsed spend value row
│       ├── ExpandedSpendCard.swift     # Expanded transaction card
│       ├── TimeFrameSheet.swift        # Time frame selection modal
│       ├── CategoryTabBar.swift        # Category filter tabs
│       ├── TransactionRow.swift        # Single transaction row
│       └── TransactionListView.swift   # Transaction list container
├── XPNZApp.swift               # App entry point
└── ContentView.swift           # Root view
```

### Key Design Patterns

- **State Management**: SwiftUI's `@State`, `@Binding`, and `@Environment` for reactive UI
- **View Composition**: Small, reusable components following single responsibility principle
- **Navigation**: NavigationStack for programmatic navigation between screens
- **Animations**: Spring-based animations for natural, responsive interactions
- **Mock Data**: Structured mock data for development and previews

## 🛠️ Technologies

- **Language**: Swift 5.9+
- **Framework**: SwiftUI
- **Platform**: iOS 17.0+
- **Design**: SF Symbols, SF Pro Rounded
- **Architecture**: MVVM-like structure with SwiftUI's declarative paradigm

## 🚀 Getting Started

### Prerequisites

- Xcode 15.0 or later
- iOS 17.0+ deployment target
- macOS Sonoma or later

### Installation

1. Clone the repository:
```bash
git clone https://github.com/sahil639/XPNZ.git
cd XPNZ
```

2. Open the project in Xcode:
```bash
open XPNZ.xcodeproj
```

3. Build and run:
   - Select a simulator or device
   - Press `⌘R` or click the Play button

### Quick Start

The app launches directly to the Home screen showing:
- Default time frames enabled: Day, Week, Month
- Mock transaction data pre-populated
- Tap any spend value to expand and see details
- Tap the bandage icon (top right) to view Save-to-Spend insights
- Tap the clock icon (top right) to customize time frames

## 📐 Code Style & Best Practices

### SwiftUI Conventions

- **MARK Comments**: Organized sections (State, Body, Subviews)
- **Private Modifiers**: Encapsulation of internal view properties
- **Computed Properties**: Extract complex view logic from body
- **View Extraction**: Keep body under 10 lines when possible
- **Descriptive Naming**: Clear, intention-revealing variable and function names

### Layout Standards

- **Horizontal Padding**: 20pt standard throughout app
- **Vertical Spacing**: 4pt, 8pt, 16pt, 24pt, 48pt scale
- **Font Sizes**: 72pt (hero), 48pt (large), 22pt (headers), 17pt (body)
- **Animation Duration**: 0.45s response with 0.75 damping for springs

## 🎨 Design Highlights

### Calendar Icon
- 8° rotation for playful, modern feel
- Red header with white background
- Current month (uppercase) and day number
- Rounded corners with subtle shadow

### Expandable Cards
- Smooth spring animation on expand/collapse
- Gray background header with white body
- 24pt corner radius for modern iOS look
- Tap header to close (entire area is tappable)
- Hide/show value button with eye icon

### Save-to-Spend Screen
- Large 72pt hero value with bold SF Rounded
- Green percentage indicator for positive savings
- Editorial layout with generous whitespace
- Bottom progressive fade effect
- Pill-style segmented control for period selection

## 🔮 Future Enhancements

Potential features for future development:

- [ ] Real transaction data integration
- [ ] Multiple currency support with live conversion
- [ ] Custom category creation
- [ ] Budget tracking and alerts
- [ ] Export data to CSV/PDF
- [ ] iCloud sync across devices
- [ ] Widgets for Lock Screen and Home Screen
- [ ] Siri Shortcuts integration
- [ ] Apple Pay transaction import
- [ ] Charts and graphs for spending trends
- [ ] Recurring transaction detection
- [ ] Split transaction support
- [ ] Photo receipts with image recognition

## 🤝 Contributing

Contributions are welcome! This is a learning project exploring SwiftUI best practices and modern iOS design patterns.

### Development Setup

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Code Review Guidelines

- Follow existing code style and conventions
- Add MARK comments for new view sections
- Extract complex views into separate components
- Test on multiple device sizes
- Ensure light/dark mode compatibility

## 📄 License

This project is open source and available under the MIT License.

## 👨‍💻 Author

**Sahil** - [sahil639](https://github.com/sahil639)

## 🙏 Acknowledgments

- Built with SwiftUI and modern iOS design patterns
- Inspired by Apple's design philosophy and HIG guidelines
- SF Symbols for iconography
- Co-developed with Claude Sonnet 4.5

---

**Note**: This app uses mock data for demonstration purposes. Future versions will support real financial data integration.
