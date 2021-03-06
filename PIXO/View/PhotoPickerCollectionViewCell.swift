//
//  PhotoPickerCollectionViewCell.swift
//  PIXO
//
//  Created by Kanghos on 2022/05/09.
//

import UIKit
import Then
import Photos

final class PhotoPickerCollectionViewCell: UICollectionViewCell {

    static let identifier = "PhotoPickerCollectionViewCell"
    let imageManager = PHImageManager()
    var representedAssetIdentifier: String?
    let scale = UIScreen.main.scale
    var thumbnailAssetSize = CGSize.zero

    var thumbnailSize: CGSize {
        let scale = UIScreen.main.scale
        return CGSize(width: (UIScreen.main.bounds.width / 3) * scale, height: (UIScreen.main.bounds.width / 3) * scale)
    }

    var thumbnailImageView = UIImageView().then {
        $0.layer.cornerRadius = Constant.cellCornerRadius
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setUpUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpUI() {
        addView()
        setUpConstraints()
    }

    private func addView() {
        contentView.addSubview(thumbnailImageView)
    }

    private func setUpConstraints() {
        thumbnailImageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(3)
        }
    }

    func configure(with image: UIImage?) {
        self.thumbnailImageView.image = image
    }


}
