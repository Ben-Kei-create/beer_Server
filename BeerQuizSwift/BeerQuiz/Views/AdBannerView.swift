import GoogleMobileAds
import SwiftUI

enum AdMobConfiguration {
    static let appID = "ca-app-pub-4859622277330192~4732107297"

    #if DEBUG
    static let bannerAdUnitID = "ca-app-pub-3940256099942544/2435281174"
    #else
    static let bannerAdUnitID = "ca-app-pub-4859622277330192/3079387929"
    #endif
}

struct AdBannerBar: View {
    var body: some View {
        GeometryReader { proxy in
            let availableWidth = max(proxy.size.width - 32, 320)
            let adSize = largeAnchoredAdaptiveBanner(width: availableWidth)

            HStack {
                Spacer(minLength: 0)
                BannerViewContainer(adSize: adSize)
                    .frame(width: adSize.size.width, height: adSize.size.height)
                    .accessibilityIdentifier("quiz_banner_ad")
                Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .overlay {
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .stroke(Color.white.opacity(0.48), lineWidth: 1)
                    }
            }
            .padding(.horizontal, 12)
            .padding(.top, 8)
            .padding(.bottom, 10)
        }
        .frame(height: 96)
    }
}

private struct BannerViewContainer: UIViewRepresentable {
    let adSize: AdSize

    func makeUIView(context: Context) -> BannerView {
        let banner = BannerView(adSize: adSize)
        banner.adUnitID = AdMobConfiguration.bannerAdUnitID
        banner.delegate = context.coordinator
        banner.load(Request())
        return banner
    }

    func updateUIView(_ banner: BannerView, context: Context) {
        guard banner.adSize.size != adSize.size else {
            return
        }

        banner.adSize = adSize
        banner.load(Request())
    }

    func makeCoordinator() -> BannerCoordinator {
        BannerCoordinator()
    }

    final class BannerCoordinator: NSObject, BannerViewDelegate {
        func bannerView(_ bannerView: BannerView, didFailToReceiveAdWithError error: Error) {
            #if DEBUG
            print("Banner ad failed to load: \(error.localizedDescription)")
            #endif
        }
    }
}
