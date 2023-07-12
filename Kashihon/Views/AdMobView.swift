//
//  AdMobView.swift
//  Kashihon
//
//  Created by t&a on 2023/07/12.
//
//

import Foundation
import GoogleMobileAds
import SwiftUI
import UIKit

// MARK: - アプリID

// テスト  : ca-app-pub-3940256099942544~1458002511
// 本番  　:

// MARK: - バナー

// テスト  :
private let bannerCode = "ca-app-pub-3940256099942544/2934735716"
// 本番
// private let bannerCode = ""

// MARK: - リワード

// テスト
private let rewardCode = "ca-app-pub-3940256099942544/1712485313"
// 本番
// private let rewardCode = ""

struct AdMobBannerView: UIViewRepresentable {
    func makeUIView(context _: Context) -> GADBannerView {
        let banner = GADBannerView(adSize: GADAdSizeBanner) // インスタンスを生成
        // 諸々の設定をしていく
        banner.adUnitID = bannerCode // 自身の広告IDに置き換える
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        banner.rootViewController = windowScene?.windows.first!.rootViewController
        let request = GADRequest()
        request.scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        banner.load(request)
        return banner // 最終的にインスタンスを返す
    }

    func updateUIView(_: GADBannerView, context _: Context) {
        // 特にないのでメソッドだけ用意
    }
}

class Reward: NSObject, ObservableObject, GADFullScreenContentDelegate {
    // リワード広告を読み込んだかどうか
    @Published var rewardLoaded: Bool = false
    // リワード広告が格納される
    private var rewardedAd: GADRewardedAd? = nil

    override init() {
        super.init()
    }

    // リワード広告の読み込み
    public func loadReward() {
        let request = GADRequest()
        request.scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        GADRewardedAd.load(withAdUnitID: rewardCode, request: request, completionHandler: { ad, error in
            if let _ = error {
                // 読み込みに失敗しました
                self.rewardLoaded = false
                return
            }
            // 読み込みに成功しました
            self.rewardLoaded = true
            self.rewardedAd = ad
            self.rewardedAd?.fullScreenContentDelegate = self
        })
    }

    // 読み込んだリワード広告を表示するメソッド
    public func showReward() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let rootVC = windowScene?.windows.first?.rootViewController
        if let ad = rewardedAd {
            ad.present(fromRootViewController: rootVC!, userDidEarnRewardHandler: {
                // 報酬を獲得
                self.rewardLoaded = false
            })
        } else {
            rewardLoaded = false
            loadReward()
        }
    }
}
