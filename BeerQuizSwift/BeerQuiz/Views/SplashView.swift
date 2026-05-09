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
                            FoamView(width: geo.size.width).transition(.opacity)
                        }
                    }
                    .frame(height: geo.size.height * beerLevel)
                }
                .ignoresSafeArea()

                ForEach(0..<60, id: \.self) { i in
                    RisingBubble(screenWidth: geo.size.width, screenHeight: geo.size.height, index: i)
                }

                VStack(spacing: 16) {
                    Text("🍺").font(.system(size: 72))
                    Text("Beer Quiz")
                        .font(.system(size: 40, weight: .black))
                        .foregroundStyle(.white)
                        .shadow(color: BeerTheme.malt.opacity(0.5), radius: 4, y: 2)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .opacity(showTitle ? 1 : 0)
                .scaleEffect(showTitle ? 1 : 0.7)
                .animation(.spring(response: 0.5, dampingFraction: 0.7), value: showTitle)
            }
            .frame(width: geo.size.width, height: geo.size.height)
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

    private var xPos: CGFloat {
        let xs: [CGFloat] = [0.05, 0.12, 0.22, 0.31, 0.40, 0.48, 0.55, 0.63, 0.70, 0.78, 0.85, 0.92,
                             0.08, 0.18, 0.27, 0.35, 0.44, 0.52, 0.60, 0.67, 0.74, 0.82, 0.90, 0.97,
                             0.03, 0.15, 0.25, 0.33, 0.42, 0.50, 0.58, 0.65, 0.72, 0.80, 0.88, 0.95,
                             0.10, 0.20, 0.30, 0.38, 0.46, 0.54, 0.62, 0.69, 0.76, 0.84, 0.91, 0.98,
                             0.06, 0.14, 0.24, 0.32, 0.41, 0.49, 0.56, 0.64, 0.71, 0.79, 0.86, 0.93]
        return xs[index % xs.count] * screenWidth
    }

    private var size: CGFloat {
        let sizes: [CGFloat] = [6, 9, 5, 11, 8, 6, 12, 5, 9, 7, 10, 4, 8, 11, 6]
        return sizes[index % sizes.count]
    }

    private var delay: Double { Double(index) * 0.04 + 0.1 }
    private var duration: Double {
        let durs: [Double] = [1.0, 1.2, 0.9, 1.3, 1.1]
        return durs[index % durs.count]
    }

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
    let width: CGFloat

    private let row1: [CGFloat] = [58, 46, 64, 38, 66, 52, 60, 44, 58, 40, 68, 50, 62, 42, 64, 54, 56, 48, 62, 44, 58, 50, 64, 42, 60, 46, 62, 50, 56, 44, 64, 48]
    private let row2: [CGFloat] = [36, 44, 32, 48, 38, 46, 30, 50, 40, 36, 50, 34, 48, 36, 44, 38, 42, 34, 46, 38, 40, 32]

    var body: some View {
        ZStack(alignment: .top) {
            HStack(spacing: -18) {
                ForEach(Array(row1.enumerated()), id: \.offset) { _, size in
                    Circle()
                        .fill(Color.white.opacity(0.92))
                        .frame(width: size, height: size * 0.82)
                }
            }
            .frame(width: width + 120)

            HStack(spacing: -14) {
                ForEach(Array(row2.enumerated()), id: \.offset) { _, size in
                    Circle()
                        .fill(Color.white.opacity(0.82))
                        .frame(width: size, height: size * 0.78)
                        .offset(y: -size * 0.45)
                }
            }
            .frame(width: width + 120)
        }
        .frame(maxWidth: .infinity)
        .offset(y: 14)
    }
}
