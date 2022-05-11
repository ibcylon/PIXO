//
//  LocalImageManager.swift
//  PIXO
//
//  Created by Kanghos on 2022/05/11.
//

import UIKit
import Photos

final class LocalImageManager {
    static var shared = LocalImageManager()
    let imageManager = PHImageManager()
    private init() {}

    var representedAssetIdentifier: String?

    func requestImage(with asset: PHAsset?, thumbnailSize: CGSize, completion: @escaping (UIImage?) -> Void) {
        guard let asset = asset else {
            completion(nil)
            return
        }
        self.representedAssetIdentifier = asset.localIdentifier
        self.imageManager.requestImage(for: asset, targetSize: thumbnailSize, contentMode: .aspectFill, options: nil, resultHandler: { image, info in
            // UIKit may have recycled this cell by the handler's activation time.
            //  print(info?["PHImageResultIsDegradedKey"])
            // Set the cell's thumbnail image only if it's still showing the same asset.
            if self.representedAssetIdentifier == asset.localIdentifier {
                completion(image)
            }
        })
    }
} 
