//
//  ShareButtonView.swift
//  Kashihon
//
//  Created by t&a on 2023/07/16.
//

import SwiftUI

struct ShareButtonView: View {
    // MARK: - シェアボタン

    private func shareApp(shareText: String, shareLink: String) {
        let items = [shareText, URL(string: shareLink)!] as [Any]
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        if UIDevice.current.userInterfaceIdiom == .pad {
            if let popPC = activityVC.popoverPresentationController {
                popPC.sourceView = activityVC.view
                popPC.barButtonItem = .none
                popPC.sourceRect = activityVC.accessibilityFrame
            }
        }
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let rootVC = windowScene?.windows.first?.rootViewController
        rootVC?.present(activityVC, animated: true, completion: {})
    }

    var body: some View {
        Button(action: {
            shareApp(shareText: "本を友達に貸した履歴を残していこう♪", shareLink: "https://apps.apple.com/jp/app/%E3%82%AB%E3%82%B7%E3%83%9B%E3%83%B3/id6451445308")
        }) {
            HStack {
                Image(systemName: "star.bubble")
                Text("「カシホン」をオススメする")
            }
        }
    }
}

struct ShareButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ShareButtonView()
    }
}
