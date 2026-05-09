import SwiftUI

struct SplashView: View {
    let onFinish: () -> Void

    @State private var beerLevel: CGFloat = 0
    @State private var showFoam = false
    @State private var showTitle = false

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color(red: 0.96, green: 0.90, blue: 0.78).ignoresSafeArea()

                VStack(spacing: 0) {
                    Spacer(minLength: 0)
                    ZStack(alignment: .top) {
                        LinearGradient(
                            colors: [BeerTheme.amber.opacity(0.85), BeerTheme.deepAmber],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        if showFoam {
                            FoamView().transition(.opacity)
                        }
                    }
                    .frame(height: geo.size.height * beerLevel)
                }
                .ignoresSafeArea()

                ForEach(0..<30, id: \.self) { i in
                    RisingBubble(screenWidth: geo.size.width, screenHeight: geo.size.height, index: i)
                }

                VStack(spacing: 16) {
                    Text("🍺").font(.system(size: 72))
                    Text("Beer Quiz")
                        .font(.system(size: 40, weight: .black))
                        .foregroundStyle(.white)
                        .shadow(color: BeerTheme.malt.opacity(0.5), radius: 4, y: 2)
                }
                .opacity(showTitle ? 1 : 0)
                .scaleEffect(showTitle ? 1 : 0.7)
                .animation(.spring(response: 0.5, dampingFraction: 0.7), value: showTitle)
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 1.4)) { beerLevel = 0.86 }
            withAnimation(.easeIn(duration: 0.3).delay(1.2)) { showFoam = true }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation { showTitle = true }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.8) {
                onFinish()
            }
        }
    }
}

private struct RisingBubble: View {
    let screenWidth: CGFloat
    let screenHeight: CGFloat
    let index: Int

    @State private var offsetY: CGFloat = 0
    @State private var opacity: CGFloat = 0

    private var xPos: CGFloat { CGFloat(index % 9) / 9.0 * screenWidth + screenWidth / 18 + CGFloat(index / 9) * 22 }
    private var size: CGFloat { [6.0, 9.0, 5.0, 11.0, 8.0, 6.0, 12.0, 5.0, 9.0][index % 9] }
    private var delay: Double { Double(index) * 0.07 + 0.1 }
    private var duration: Double { [1.0, 1.2, 0.9, 1.3, 1.1][index % 5] }

    var body: some View {
        Circle()
            .fill(Color.white.opacity(0.55))
            .frame(width: size, height: size)
            .position(x: xPos, y: screenHeight - offsetY)
            .opacity(opacity)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    withAnimation(.easeIn(duration: 0.2)) { opacity = 0.7 }
                    withAnimation(.linear(duration: duration)) { offsetY = screenHeight * 0.9 }
                    withAnimation(.easeOut(duration: 0.3).delay(duration - 0.3)) { opacity = 0 }
                }
            }
    }
}

private struct FoamView: View {
    private let row1: [CGFloat] = [58, 46, 64, 38, 66, 52, 60, 44, 58, 40, 68, 50, 62, 42, 64, 54, 56, 48, 62, 44]
    private let row2: [CGFloat] = [36, 44, 32, 48, 38, 46, 30, 50, 40, 36, 50, 34, 48, 36, 44, 38]

    var body: some View {
        ZStack(alignment: .top) {
            HStack(spacing: -16) {
                ForEach(Array(row1.enumerated()), id: \.offset) { _, size in
                    Circle()
                        .fill(Color.white.opacity(0.92))
                        .frame(width: size, height: size * 0.82)
                }
            }
            .frame(maxWidth: .infinity)

            HStack(spacing: -12) {
                ForEach(Array(row2.enumerated()), id: \.offset) { _, size in
                    Circle()
                        .fill(Color.white.opacity(0.82))
                        .frame(width: size, height: size * 0.78)
                        .offset(y: -size * 0.45)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
        .offset(y: 14)
    }
}
