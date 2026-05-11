import SwiftUI

enum BeerTheme {
    static let amber = Color(red: 0.96, green: 0.62, blue: 0.16)
    static let deepAmber = Color(red: 0.72, green: 0.39, blue: 0.12)
    static let malt = Color(red: 0.55, green: 0.31, blue: 0.17)
    static let foam = Color(red: 1.0, green: 0.96, blue: 0.86)
    static let hop = Color(red: 0.27, green: 0.55, blue: 0.29)
    static let skyFoam = Color(red: 0.70, green: 0.87, blue: 0.92)
    static let berry = Color(red: 0.76, green: 0.29, blue: 0.33)
}

struct BeerBackdrop: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.99, green: 0.95, blue: 0.85),
                    Color(red: 1.0, green: 0.92, blue: 0.68),
                    Color(red: 0.99, green: 0.80, blue: 0.40),
                    Color(red: 0.98, green: 0.78, blue: 0.38)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            RadialGradient(
                colors: [
                    Color.white.opacity(0.72),
                    Color.white.opacity(0.08),
                    Color.clear
                ],
                center: .topLeading,
                startRadius: 30,
                endRadius: 480
            )

            FloatingBeerIcons()
        }
        .ignoresSafeArea()
    }
}

private struct FloatingBeerIcon: Identifiable {
    let id = UUID()
    let symbol: String
    let x: CGFloat
    let y: CGFloat
    let size: CGFloat
    let phase: Double
    let speed: Double
    let driftX: CGFloat
    let driftY: CGFloat
    let rotation: Double
    let color: Color
    let opacity: Double
}

private struct FloatingBeerIcons: View {
    private let icons: [FloatingBeerIcon] = [
        FloatingBeerIcon(symbol: "cloud.fill", x: 0.18, y: 0.14, size: 84, phase: 0.1, speed: 0.34, driftX: 15, driftY: 12, rotation: 4, color: .white, opacity: 0.58),
        FloatingBeerIcon(symbol: "cloud.fill", x: 0.76, y: 0.19, size: 62, phase: 1.7, speed: 0.28, driftX: 18, driftY: 10, rotation: 5, color: BeerTheme.skyFoam, opacity: 0.48),
        FloatingBeerIcon(symbol: "circle.fill", x: 0.90, y: 0.36, size: 24, phase: 0.6, speed: 0.44, driftX: 8, driftY: 20, rotation: 0, color: .white, opacity: 0.56),
        FloatingBeerIcon(symbol: "circle.fill", x: 0.12, y: 0.38, size: 18, phase: 2.4, speed: 0.42, driftX: 12, driftY: 18, rotation: 0, color: .white, opacity: 0.48),
        FloatingBeerIcon(symbol: "circle.fill", x: 0.44, y: 0.28, size: 12, phase: 3.2, speed: 0.55, driftX: 10, driftY: 16, rotation: 0, color: .white, opacity: 0.42),
        FloatingBeerIcon(symbol: "leaf.fill", x: 0.84, y: 0.66, size: 44, phase: 4.1, speed: 0.23, driftX: 14, driftY: 14, rotation: 12, color: BeerTheme.hop, opacity: 0.36),
        FloatingBeerIcon(symbol: "leaf.fill", x: 0.20, y: 0.74, size: 38, phase: 2.9, speed: 0.25, driftX: 12, driftY: 15, rotation: 11, color: BeerTheme.hop, opacity: 0.30),
        FloatingBeerIcon(symbol: "sparkles", x: 0.67, y: 0.48, size: 30, phase: 5.3, speed: 0.38, driftX: 10, driftY: 12, rotation: 8, color: BeerTheme.berry, opacity: 0.30),
        FloatingBeerIcon(symbol: "drop.fill", x: 0.37, y: 0.62, size: 22, phase: 1.1, speed: 0.48, driftX: 9, driftY: 22, rotation: 7, color: BeerTheme.skyFoam, opacity: 0.40)
    ]

    var body: some View {
        GeometryReader { proxy in
            TimelineView(.animation) { timeline in
                let time = timeline.date.timeIntervalSinceReferenceDate

                ZStack {
                    ForEach(icons) { icon in
                        let wave = sin(time * icon.speed + icon.phase)
                        let bob = cos(time * icon.speed * 0.85 + icon.phase)

                        Image(systemName: icon.symbol)
                            .font(.system(size: icon.size, weight: .bold))
                            .foregroundStyle(icon.color.opacity(icon.opacity))
                            .rotationEffect(.degrees(wave * icon.rotation))
                            .position(
                                x: proxy.size.width * icon.x + CGFloat(wave) * icon.driftX,
                                y: proxy.size.height * icon.y + CGFloat(bob) * icon.driftY
                            )
                    }
                }
                .frame(width: proxy.size.width, height: proxy.size.height)
            }
        }
        .allowsHitTesting(false)
    }
}

struct BeerPanel<Content: View>: View {
    private let cornerRadius: CGFloat
    private let content: () -> Content

    init(cornerRadius: CGFloat = 24, @ViewBuilder content: @escaping () -> Content) {
        self.cornerRadius = cornerRadius
        self.content = content
    }

    var body: some View {
        content()
            .padding(18)
            .background {
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .overlay {
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                            .stroke(Color.white.opacity(0.55), lineWidth: 1)
                    }
                    .shadow(color: BeerTheme.malt.opacity(0.15), radius: 18, x: 0, y: 12)
            }
    }
}

struct BeerChip: View {
    let title: String
    let color: Color

    var body: some View {
        Text(title)
            .font(.caption.weight(.bold))
            .foregroundStyle(BeerTheme.malt)
            .padding(.horizontal, 13)
            .padding(.vertical, 8)
            .background(color.opacity(0.18), in: Capsule())
            .overlay {
                Capsule()
                    .stroke(Color.white.opacity(0.58), lineWidth: 1)
            }
    }
}

struct BeerPrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline.weight(.bold))
            .foregroundStyle(.white)
            .padding(.vertical, 17)
            .padding(.horizontal, 18)
            .background {
                Capsule()
                    .fill(
                        LinearGradient(
                            colors: [
                                BeerTheme.deepAmber,
                                BeerTheme.amber,
                                Color(red: 1.0, green: 0.75, blue: 0.20)
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .overlay(alignment: .topLeading) {
                        Capsule()
                            .fill(Color.white.opacity(0.28))
                            .frame(height: 14)
                            .padding(.horizontal, 16)
                            .padding(.top, 6)
                    }
                    .shadow(color: BeerTheme.deepAmber.opacity(configuration.isPressed ? 0.12 : 0.32), radius: configuration.isPressed ? 6 : 16, x: 0, y: configuration.isPressed ? 4 : 10)
            }
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.spring(response: 0.24, dampingFraction: 0.82), value: configuration.isPressed)
    }
}

struct BeerSecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline.weight(.semibold))
            .foregroundStyle(BeerTheme.malt)
            .padding(.vertical, 15)
            .padding(.horizontal, 18)
            .background {
                Capsule()
                    .fill(.ultraThinMaterial)
                    .overlay {
                        Capsule()
                            .stroke(Color.white.opacity(0.58), lineWidth: 1)
                    }
            }
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
    }
}
