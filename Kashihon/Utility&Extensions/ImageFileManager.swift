//
//  ImageFileManager.swift
//  Kashihon
//
//  Created by t&a on 2023/07/16.
//

import SwiftUI
import UIKit

class ImageFileManager {
    // MARK: - パスの構築

    private func docURL(_ fileName: String) -> URL? {
        do {
            // Docmentsフォルダを取得
            let docsUrl = try FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false
            )
            // URLを構築
            let url = docsUrl.appendingPathComponent(fileName)
            return url
        } catch {
            return nil
        }
    }

    public func savingImage(urlStr: String) {
        do {
            // URLの文字列をUIImage型に変換
            guard let url = URL(string: urlStr) else { return }
            let data = try Data(contentsOf: url)
            guard let image = UIImage(data: data) else { return }
            guard let imageData = image.jpegData(compressionQuality: 1.0) else { return }

            let name = urlStr.replacingOccurrences(of: "/", with: "!") // 変換
            try imageData.write(to: docURL("\(name).jpg")!)
            print("画像を保存できました")
        } catch {
            print("savingImage")
            print("\(error)")
        }
    }

    public func loadImage(urlStr: String) -> Image {
        let name = urlStr.replacingOccurrences(of: "/", with: "!") // 変換
        let path = docURL("\(name).jpg")!.path
        if FileManager.default.fileExists(atPath: path) {
            if let image = UIImage(contentsOfFile: path) {
                return Image(uiImage: image)
            } else {
                print("読み込みに失敗しました")
            }
        } else {
            print("画像が見つかりませんでした")
        }
        return Image(systemName: "trash")
    }
}
