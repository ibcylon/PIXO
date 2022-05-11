//
//  PhotoPickerViewModel.swift
//  PIXO
//
//  Created by Kanghos on 2022/05/09.
//

import UIKit
import Photos

final class PhotoPickerViewModel {
    var allPhotos: PHFetchResult<PHAsset>? {
        didSet {
            numberOfRowsInSection = allPhotos?.count ?? 0
        }
    }
    let scale = UIScreen.main.scale
    var thumbnailSize = CGSize.zero
    var numberOfRowsInSection: Int = 0

    init() {
        fetchAsset()
        self.thumbnailSize = CGSize(width: 1024 * self.scale, height: 1024 * self.scale)
    }

    func fetchAsset() {
        self.allPhotos = PHAsset.fetchAssets(with: nil)
    }

    func getAsset(_ index: Int) -> PHAsset? {
        allPhotos?[index]
    }

    func requestImage(_ index: Int, completion: @escaping (UIImage?) -> Void) {
        LocalImageManager.shared.requestImage(with: getAsset(index), thumbnailSize: self.thumbnailSize, completion: { image in
            completion(image)
        })
    }

    func getResourceName(_ index: Int) -> String {
        let resources = PHAssetResource.assetResources(for: getAsset(index)!)
        let name = resources.first!.originalFilename

        return name
    }



}
