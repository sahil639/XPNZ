import SwiftUI

/// A glossy 3D lever/slider track component with glass bubble thumb
struct LeverTrackView: View {
    // ⚡ EDITABLE: Bubble position — 0.0 = fully Spend (left), 1.0 = fully Save (right)
    var bubblePosition: CGFloat = 0.5

    // ⚡ EDITABLE: Track dimensions
    private let trackHeight: CGFloat = 56
    private let trackCornerRadius: CGFloat = 28 // Half of height for full pill shape

    // ⚡ EDITABLE: Border parameters
    private let borderWidth: CGFloat = 5 // ⚡ EDITABLE: Total border thickness
    private let borderGradientOuter = Color(red: 0.2, green: 0.2, blue: 0.2) // ⚡ EDITABLE: Outer border color (dark gray)
    private let borderGradientInner = Color(red: 0.35, green: 0.35, blue: 0.35) // ⚡ EDITABLE: Inner border color (lighter gray)

    // ⚡ EDITABLE: Shadow parameters — smoother & softer
    private let shadowColor1 = Color.black.opacity(0.25) // ⚡ EDITABLE: Primary shadow opacity
    private let shadowRadius1: CGFloat = 12              // ⚡ EDITABLE: Primary shadow blur
    private let shadowY1: CGFloat = 6                    // ⚡ EDITABLE: Primary shadow offset
    private let shadowColor2 = Color.black.opacity(0.1)  // ⚡ EDITABLE: Secondary ambient shadow opacity
    private let shadowRadius2: CGFloat = 20              // ⚡ EDITABLE: Secondary shadow blur
    private let shadowY2: CGFloat = 10                   // ⚡ EDITABLE: Secondary shadow offset

    // ⚡ EDITABLE: Divider line parameters
    private let dividerColor = Color(red: 0.15, green: 0.35, blue: 0.05) // ⚡ EDITABLE: Divider line color
    private let dividerOpacity: Double = 0.6     // ⚡ EDITABLE: Divider line opacity
    private let dividerWidth: CGFloat = 1.5      // ⚡ EDITABLE: Divider line thickness
    private let dividerPairGap: CGFloat = 5      // ⚡ EDITABLE: Gap between each pair of lines

    // ⚡ EDITABLE: Label styling
    private let labelFont: Font = .system(size: 14, weight: .medium)
    private let labelColor = Color(.systemGray)  // ⚡ EDITABLE: Label text color
    private let labelTopPadding: CGFloat = 14    // ⚡ EDITABLE: Space between track and labels

    // ⚡ EDITABLE: Bubble dimensions (from Figma: 63x46, cornerRadius 60)
    private let bubbleWidth: CGFloat = 63        // ⚡ EDITABLE: Bubble width
    private let bubbleHeight: CGFloat = 46       // ⚡ EDITABLE: Bubble height
    private let bubbleCornerRadius: CGFloat = 60 // ⚡ EDITABLE: Bubble corner radius (fully rounded)

    var body: some View {
        VStack(spacing: 0) {
            // Lever track with bubble
            ZStack {
                // Border frame — gradient stroke for beveled look
                Capsule()
                    .fill(
                        // ⚡ EDITABLE: Border gradient for 3D beveled frame
                        LinearGradient(
                            stops: [
                                .init(color: borderGradientInner, location: 0.0),  // ⚡ EDITABLE: Top border (lighter)
                                .init(color: borderGradientOuter, location: 0.3),  // ⚡ EDITABLE: Upper mid border
                                .init(color: Color.black, location: 0.5),          // ⚡ EDITABLE: Center border (darkest)
                                .init(color: borderGradientOuter, location: 0.7),  // ⚡ EDITABLE: Lower mid border
                                .init(color: borderGradientInner, location: 1.0),  // ⚡ EDITABLE: Bottom border (lighter)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(height: trackHeight + borderWidth * 2)

                // Green gradient fill (base 3D tube) — more vibrant
                Capsule()
                    .fill(
                        // ⚡ EDITABLE: Change gradient colors and stop positions to adjust the base fill
                        LinearGradient(
                            stops: [
                                .init(color: Color(hex: "4D9A10"), location: 0.0),   // ⚡ EDITABLE: Dark green edge (top)
                                .init(color: Color(hex: "5CB818"), location: 0.08),  // ⚡ EDITABLE: Transition to green
                                .init(color: Color(hex: "72D020"), location: 0.20),  // ⚡ EDITABLE: Vibrant green
                                .init(color: Color(hex: "B8F04E"), location: 0.42),  // ⚡ EDITABLE: Bright highlight start
                                .init(color: Color(hex: "C8F55A"), location: 0.50),  // ⚡ EDITABLE: Peak highlight (belly of tube)
                                .init(color: Color(hex: "B0E840"), location: 0.58),  // ⚡ EDITABLE: Highlight end
                                .init(color: Color(hex: "7BC422"), location: 0.75),  // ⚡ EDITABLE: Back to vibrant green
                                .init(color: Color(hex: "5EA318"), location: 0.90),  // ⚡ EDITABLE: Darker green
                                .init(color: Color(hex: "4A8A12"), location: 1.0),   // ⚡ EDITABLE: Dark green edge (bottom)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(height: trackHeight)
                    .padding(.horizontal, borderWidth)

                // Inner shadow — top glossy highlight
                Capsule()
                    .fill(
                        // ⚡ EDITABLE: Top inner highlight — glossy tube reflection
                        LinearGradient(
                            stops: [
                                .init(color: Color.white.opacity(0.50), location: 0.0),  // ⚡ EDITABLE: Peak highlight brightness
                                .init(color: Color.white.opacity(0.25), location: 0.10), // ⚡ EDITABLE: Highlight mid
                                .init(color: Color.white.opacity(0.08), location: 0.25), // ⚡ EDITABLE: Highlight fade
                                .init(color: Color.clear, location: 0.40),                // ⚡ EDITABLE: Fade-out point
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(height: trackHeight)
                    .padding(.horizontal, borderWidth)

                // Inner shadow — bottom depth
                Capsule()
                    .fill(
                        // ⚡ EDITABLE: Bottom inner shadow — depth underneath
                        LinearGradient(
                            stops: [
                                .init(color: Color.clear, location: 0.65),                 // ⚡ EDITABLE: Shadow start point
                                .init(color: Color.black.opacity(0.06), location: 0.80),   // ⚡ EDITABLE: Subtle shadow
                                .init(color: Color.black.opacity(0.15), location: 0.95),   // ⚡ EDITABLE: Bottom shadow intensity
                                .init(color: Color.black.opacity(0.20), location: 1.0),    // ⚡ EDITABLE: Bottom edge darkness
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(height: trackHeight)
                    .padding(.horizontal, borderWidth)

                // Inner edge ring — subtle dark line along the inside of the border
                Capsule()
                    .strokeBorder(
                        // ⚡ EDITABLE: Inner edge ring gradient
                        LinearGradient(
                            stops: [
                                .init(color: Color.black.opacity(0.3), location: 0.0),  // ⚡ EDITABLE: Top edge ring
                                .init(color: Color.black.opacity(0.15), location: 0.3), // ⚡ EDITABLE: Mid edge
                                .init(color: Color.black.opacity(0.1), location: 0.7),  // ⚡ EDITABLE: Lower edge
                                .init(color: Color.black.opacity(0.25), location: 1.0), // ⚡ EDITABLE: Bottom edge ring
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        lineWidth: 1.5 // ⚡ EDITABLE: Inner edge ring thickness
                    )
                    .frame(height: trackHeight)
                    .padding(.horizontal, borderWidth)

                // Divider tick marks — 2 pairs (4 lines total)
                dividerLines
                    .frame(height: trackHeight)
                    .clipShape(Capsule())

                // Glass bubble thumb
                glassBubble
            }
            // ⚡ EDITABLE: Soft layered drop shadows
            .shadow(color: shadowColor1, radius: shadowRadius1, x: 0, y: shadowY1)
            .shadow(color: shadowColor2, radius: shadowRadius2, x: 0, y: shadowY2)

            // Labels below the lever
            HStack {
                Text("Spend")
                    .font(labelFont)             // ⚡ EDITABLE: Label font
                    .foregroundColor(labelColor)  // ⚡ EDITABLE: Label color

                Spacer()

                Text("Save")
                    .font(labelFont)             // ⚡ EDITABLE: Label font
                    .foregroundColor(labelColor)  // ⚡ EDITABLE: Label color
            }
            .padding(.top, labelTopPadding) // ⚡ EDITABLE: Space between track and labels
            .padding(.horizontal, 8)
        }
    }

    // MARK: - Glass Bubble

    private var glassBubble: some View {
        GeometryReader { geometry in
            let trackWidth = geometry.size.width
            // ⚡ EDITABLE: Inset so bubble stays within the lever capsule
            let inset = bubbleWidth / 2 + borderWidth + 2 // ⚡ EDITABLE: Edge padding
            let travelRange = trackWidth - inset * 2
            let clampedPosition = min(max(bubblePosition, 0), 1)
            let xOffset = inset + travelRange * clampedPosition

            // iOS 26 Liquid Glass bubble — 2% white fill + .glassEffect refraction
            liquidGlassBubble
                // ⚡ EDITABLE: Drop shadow (Figma: X:0, Y:2, Blur:2, #000000 12%)
                .shadow(color: Color.black.opacity(0.02), radius: 2, x: 0, y: 4)
                .position(x: xOffset, y: geometry.size.height / 2)
                .animation(.timingCurve(0.25, 0.1, 0.25, 1.0, duration: 0.6), value: bubblePosition) // ⚡ EDITABLE: Slide animation
        }
        .frame(height: trackHeight + borderWidth * 2)
    }

    // MARK: - Liquid Glass Bubble Design
    // ⚡ EDIT THIS to customize the bubble appearance.
    //   - bubbleWidth: 63, bubbleHeight: 46, bubbleCornerRadius: 60 (defined above)
    //   - Add .fill(), .stroke(), .overlay(), .shadow() etc. inside the container
    //   - .glassEffect(.regular, in:) applies the iOS 26 Liquid Glass refraction
    //   - Try .glassEffect(.clear, in:) for a more transparent variant
    private var liquidGlassBubble: some View {
        GlassEffectContainer {
            // ⚡ BUBBLE SHAPE — edit fill, stroke, overlays here
            RoundedRectangle(cornerRadius: bubbleCornerRadius)
                // ⚡ FILL: change to Color.white.opacity(0.06) etc.
                .frame(width: bubbleWidth, height: bubbleHeight)
                // ⚡ INNER SHADOW — change Color.yellow, radius, x, y to adjust
                .overlay(
                    RoundedRectangle(cornerRadius: bubbleCornerRadius)
                        .stroke(Color.white, lineWidth: 4) // ⚡ EDITABLE: shadow color & thickness
                        .blur(radius: 2)                     // ⚡ EDITABLE: blur spread
                        .offset(x: 0, y: 4)                  // ⚡ EDITABLE: shadow offset
                        .blendMode(.overlay)
                    
                        .clipShape(RoundedRectangle(cornerRadius: bubbleCornerRadius))
                )
                // ⚡ GLASS EFFECT — change .regular to .clear, or remove entirely
                .glassEffect(.clear, in: RoundedRectangle(cornerRadius: bubbleCornerRadius))
        }
    }

    // MARK: - Divider Lines

    private var dividerLines: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height

            // ⚡ EDITABLE: Divider positions — 2 pairs evenly spaced
            let leftCenter = width * 0.25   // ⚡ EDITABLE: Left pair center position
            let rightCenter = width * 0.75  // ⚡ EDITABLE: Right pair center position
            let halfGap = dividerPairGap / 2.5

            ZStack {
                // Left pair — line 1
                Rectangle()
                    .fill(dividerColor.opacity(dividerOpacity)) // ⚡ EDITABLE: Line color & opacity
                    .frame(width: dividerWidth)                  // ⚡ EDITABLE: Line thickness
                    .position(x: leftCenter - halfGap, y: height / 2)
                    .blendMode(.overlay) // ⚡ EDITABLE: Blending mode (.overlay, .multiply, .softLight)

                // Left pair — line 2
                Rectangle()
                    .fill(dividerColor.opacity(dividerOpacity)) // ⚡ EDITABLE: Line color & opacity
                    .frame(width: dividerWidth)                  // ⚡ EDITABLE: Line thickness
                    .position(x: leftCenter + halfGap, y: height / 2)
                    .blendMode(.overlay) // ⚡ EDITABLE: Blending mode

                // Right pair — line 1
                Rectangle()
                    .fill(dividerColor.opacity(dividerOpacity)) // ⚡ EDITABLE: Line color & opacity
                    .frame(width: dividerWidth)                  // ⚡ EDITABLE: Line thickness
                    .position(x: rightCenter - halfGap, y: height / 2)
                    .blendMode(.overlay) // ⚡ EDITABLE: Blending mode

                // Right pair — line 2
                Rectangle()
                    .fill(dividerColor.opacity(dividerOpacity)) // ⚡ EDITABLE: Line color & opacity
                    .frame(width: dividerWidth)                  // ⚡ EDITABLE: Line thickness
                    .position(x: rightCenter + halfGap, y: height / 2)
                    .blendMode(.overlay) // ⚡ EDITABLE: Blending mode
            }
        }
    }
}

// MARK: - Color Hex Extension

extension Color {
    /// Initialize a Color from a hex string (e.g. "61B01E")
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hex.count {
        case 6:
            (r, g, b) = ((int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (0, 0, 0)
        }
        self.init(
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255
        )
    }
}

#Preview {
    ZStack {
        Color(.systemBackground)
            .ignoresSafeArea()

        LeverTrackView(bubblePosition: 0.65)
            .padding(.horizontal, 40)
    }
}
