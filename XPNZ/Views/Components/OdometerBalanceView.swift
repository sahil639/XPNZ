import SwiftUI

/// Animated odometer/slot-machine style balance display
/// Each digit rolls independently with staggered timing for a cascading effect
struct OdometerBalanceView: View {
    let amount: String           // e.g. "+$428" or "-$1,247"
    let percentage: String       // e.g. "+18%"
    let isPositive: Bool
    let description: String      // e.g. "toward saving"

    // ⚡ EDITABLE: Animation parameters
    private let digitAnimationDuration: Double = 0.5   // ⚡ EDITABLE: Base animation duration per digit
    private let staggerDelay: Double = 0.06            // ⚡ EDITABLE: Delay between each digit's animation
    private let animationSpring = Animation.spring(response: 0.5, dampingFraction: 0.82) // ⚡ EDITABLE: Spring feel

    // ⚡ EDITABLE: Typography
    private let amountFontSize: CGFloat = 65           // ⚡ EDITABLE: Main dollar amount font size
    private let amountFontWeight: Font.Weight = .bold  // ⚡ EDITABLE: Main dollar amount weight
    private let percentageFontSize: CGFloat = 17       // ⚡ EDITABLE: Percentage badge font size
    private let descriptionFontSize: CGFloat = 17      // ⚡ EDITABLE: Description text font size

    // ⚡ EDITABLE: Percentage badge
    private let badgePaddingH: CGFloat = 8             // ⚡ EDITABLE: Badge horizontal padding
    private let badgePaddingV: CGFloat = 4             // ⚡ EDITABLE: Badge vertical padding
    private let badgeBackgroundOpacity: Double = 0.15  // ⚡ EDITABLE: Badge background opacity

    var body: some View {
        VStack(spacing: 8) { // ⚡ EDITABLE: Spacing between amount and badge row
            // Odometer digits
            HStack(spacing: 0) {
                ForEach(Array(amount.enumerated()), id: \.offset) { index, char in
                    if char.isNumber {
                        OdometerDigitView(
                            digit: Int(String(char)) ?? 0,
                            animation: animationSpring.delay(staggerDelay * Double(amount.count - 1 - index)) // ⚡ EDITABLE: Rightmost digit animates first
                        )
                        .frame(width: digitWidth(for: char)) // ⚡ EDITABLE: Digit width
                    } else {
                        // Static characters: $, +, -, commas
                        Text(String(char))
                            .font(.system(size: amountFontSize, weight: amountFontWeight, design: .rounded)) // ⚡ EDITABLE: Static char font
                            .foregroundColor(.primary) // ⚡ EDITABLE: Static char color
                    }
                }
            }

            // Percentage badge + description
            HStack(spacing: 4) { // ⚡ EDITABLE: Spacing between badge and description
                Text(percentage)
                    .font(.system(size: percentageFontSize, weight: .semibold)) // ⚡ EDITABLE: Badge font
                    .foregroundColor(isPositive ? .green : .red) // ⚡ EDITABLE: Badge text color
                    .padding(.horizontal, badgePaddingH)
                    .padding(.vertical, badgePaddingV)
                    .background(
                        Capsule()
                            .fill(isPositive ? Color.green.opacity(badgeBackgroundOpacity) : Color.red.opacity(badgeBackgroundOpacity)) // ⚡ EDITABLE: Badge background
                    )

                Text(description)
                    .font(.system(size: descriptionFontSize, weight: .regular)) // ⚡ EDITABLE: Description font
                    .foregroundColor(.secondary) // ⚡ EDITABLE: Description color
            }
        }
        .frame(maxWidth: .infinity)
    }

    /// Width for each character slot — digits are monospaced, symbols are narrower
    private func digitWidth(for char: Character) -> CGFloat {
        // ⚡ EDITABLE: Character widths
        return amountFontSize * 0.62 // ⚡ EDITABLE: Digit width ratio
    }
}

/// A single odometer digit that scrolls vertically through 0-9 with motion blur
struct OdometerDigitView: View {
    let digit: Int
    let animation: Animation

    // ⚡ EDITABLE: Digit appearance
    private let fontSize: CGFloat = 65          // ⚡ EDITABLE: Digit font size (match parent)
    private let fontWeight: Font.Weight = .bold // ⚡ EDITABLE: Digit font weight
    private let clipHeight: CGFloat = 78        // ⚡ EDITABLE: Visible height of one digit (controls clipping)

    // ⚡ EDITABLE: Motion blur parameters
    private let motionBlurAmount: CGFloat = 2   // ⚡ EDITABLE: Max vertical blur during animation
    private let blurAnimationDuration: Double = 0.5 // ⚡ EDITABLE: How long before blur starts fading

    @State private var animatedDigit: Int = 0
    @State private var isAnimating: Bool = false

    var body: some View {
        // Stack of digits 0-9, offset to show the current one
        GeometryReader { _ in
            VStack(spacing: 0) {
                ForEach(0..<10, id: \.self) { number in
                    Text("\(number)")
                        .font(.system(size: fontSize, weight: fontWeight, design: .rounded)) // ⚡ EDITABLE: Digit font
                        .foregroundColor(.primary) // ⚡ EDITABLE: Digit color
                        .frame(height: clipHeight) // ⚡ EDITABLE: Each digit cell height
                }
            }
            .offset(y: -CGFloat(animatedDigit) * clipHeight) // ⚡ EDITABLE: Scroll offset calculation
        }
        .frame(height: clipHeight) // ⚡ EDITABLE: Clip to single digit height
        .clipped()
        // ⚡ EDITABLE: Motion blur — vertical blur during digit roll for realism
        .blur(radius: isAnimating ? motionBlurAmount : 0, opaque: false)
        .onAppear {
            triggerAnimation(to: digit)
        }
        .onChange(of: digit) { _, newValue in
            triggerAnimation(to: newValue)
        }
    }

    private func triggerAnimation(to newValue: Int) {
        // Start subtle motion blur
        withAnimation(.easeIn(duration: 0.1)) { // ⚡ EDITABLE: Blur onset speed
            isAnimating = true
        }
        // Animate the digit scroll
        withAnimation(animation) {
            animatedDigit = newValue
        }
        // Fade out motion blur smoothly over remaining 800ms window
        DispatchQueue.main.asyncAfter(deadline: .now() + blurAnimationDuration) {
            withAnimation(.easeOut(duration: 0.3)) { // ⚡ EDITABLE: Blur fade-out speed
                isAnimating = false
            }
        }
    }
}

#Preview {
    VStack(spacing: 40) {
        OdometerBalanceView(
            amount: "+$428",
            percentage: "+18%",
            isPositive: true,
            description: "toward saving"
        )

        OdometerBalanceView(
            amount: "-$1,247",
            percentage: "-23%",
            isPositive: false,
            description: "toward spending"
        )
    }
    .padding()
}
