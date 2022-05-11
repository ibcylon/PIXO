//
//  PhotoPickerCollectionViewCell.swift
//  PIXO
//
//  Created by Kanghos on 2022/05/09.
//

import UIKit
import Then
import Photos

final class StickerCollectionViewCell: UICollectionViewCell {

    static let identifier = "StickerCollectionViewCell"

    var thumbnailImageView = UIImageView().then {
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.brown.cgColor
        $0.contentMode = .scaleAspectFill
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
            $0.size.equalTo(UIScreen.main.bounds.width / 4 - 10)

        }
    }
}
