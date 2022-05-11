//
//  ImageVIewController.swift
//  PIXO
//
//  Created by Kanghos on 2022/05/12.
//

import UIKit
import Toast

final class StickerViewController: UIViewController {

    var mainView = StickerView()
    var viewModel = StickerViewModel()

    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.mainView.collectionView.delegate = self

        setHeader()
    }

    func setHeader() {
        self.mainView.dismissButton.addTarget(self, action: #selector(dismissButtonClicked), for: .touchUpInside)
        self.mainView.overlayButton.addTarget(self, action: #selector(overlayButtonClicked), for: .touchUpInside)
    }

    @objc func dismissButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }

    // https://ios-development.tistory.com/237
    // View to Image and Share
    @objc func overlayButtonClicked() {
        if self.mainView.stickerImageView.isHidden == true {
            self.view.makeToast("스티커를 먼저 골라주세요")

            return
        }

        guard let shareImage = self.mainView.backgroundImageView.transfromToImage()
        else {
            return
        }

        let shareActivity = UIActivityViewController(activityItems: [shareImage], applicationActivities: nil)
        //shareActivity.excludedActivityTypes = [.saveToCameraRoll]
        present(shareActivity, animated: true)
    }
}

extension StickerViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = UIScreen.main.bounds.width / 4
        return CGSize(width: size, height: size)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        guard let sticker = UIImage(named: "\(indexPath.item + 1)")
        else {
            return
        }

        // 동일한 스티커 한 번 더 누르면 스티커 제거
        if self.mainView.stickerImageView.image == sticker && self.mainView.stickerImageView.isHidden == false {
            self.mainView.stickerImageView.isHidden = true

            return
        }

        self.mainView.stickerImageView.image = sticker
        self.mainView.stickerImageView.isHidden = false

        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        self.mainView.stickerImageView.isHidden = true
    }
}
