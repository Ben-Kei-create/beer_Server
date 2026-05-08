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
    private let adSize = AdSizeBanner

    var body: some View {
        HStack {
            Spacer(minLength: 0)
            BannerViewContainer(adSize: adSize)
                .frame(width: adSize.size.width, height: adSize.size.height)

                .accessibilityIdentifier("quiz_banner_ad")
            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity)
        .background(Color.black.opacity(0.08))
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
