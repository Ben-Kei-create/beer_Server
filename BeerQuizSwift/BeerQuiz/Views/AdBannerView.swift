
import GoogleMobileAds
import SwiftUI

enum AdMobConfiguration {
    static let appID = "ca-app-pub-4859622277330192~4732107297"

    #if DEBUG
    static let bannerAdUnitID = "ca-app-pub-3940256099942544/2934735716"
    #else
    static let bannerAdUnitID = "ca-app-pub-4859622277330192/3079387929"
    #endif
}

struct AdBannerBar: View {
    @State private var adHeight: CGFloat = 50

    var body: some View {
        HStack {
            Spacer(minLength: 0)
            BannerViewContainer(onHeightChange: { height in
                adHeight = height
            })
            .frame(height: adHeight)
            .accessibilityIdentifier("quiz_banner_ad")
            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity)
        .background(Color.black.opacity(0.08))
    }
}

private struct BannerViewContainer: UIViewRepresentable {
    let onHeightChange: (CGFloat) -> Void

    func makeUIView(context: Context) -> BannerView {
        let banner = BannerView(adSize: AdSizeBanner)
        banner.adUnitID = AdMobConfiguration.bannerAdUnitID
        banner.delegate = context.coordinator
        banner.load(Request())
        return banner
    }

    func updateUIView(_ banner: BannerView, context: Context) {}

    func makeCoordinator() -> BannerCoordinator {
        BannerCoordinator(onHeightChange: onHeightChange)
    }

    final class BannerCoordinator: NSObject, BannerViewDelegate {
        let onHeightChange: (CGFloat) -> Void

        init(onHeightChange: @escaping (CGFloat) -> Void) {
            self.onHeightChange = onHeightChange
        }

        func bannerViewDidReceiveAd(_ bannerView: BannerView) {
            onHeightChange(bannerView.adSize.size.height)
        }

        func bannerView(_ bannerView: BannerView, didFailToReceiveAdWithError error: Error) {
            #if DEBUG
            print("Banner ad failed to load: \(error.localizedDescription)")
            #endif
        }
    }
}
