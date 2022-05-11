//
//  PhotoPickerCollectionViewCell.swift
//  PIXO
//
//  Created by Kanghos on 2022/05/09.
//

import UIKit
import Then
import Photos

final class PhotoPickerTableViewCell: UITableViewCell {

    static let identifier = "PhotoPickerTableViewCell"
    let imageManager = PHImageManager()
    var representedAssetIdentifier: String?

    var thumbnailSize: CGSize {
        let scale = UIScreen.main.scale
        return CGSize(width: (UIScreen.main.bounds.width / 3) * scale, height: (UIScreen.main.bounds.width / 3) * scale)
    }

    var thumbnailImageView = UIImageView().then {
        $0.layer.cornerRadius = Constant.cellCornerRadius
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }

    var label = UILabel().then {
        $0.textAlignment = .left
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 16)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        setUpUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpUI() {

        self.backgroundColor = .white
        addView()
        setUpConstraints()
    }

    private func addView() {

        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(label)
    }

    private func setUpConstraints() {
        thumbnailImageView.snp.makeConstraints {
            $0.size.equalTo(100)
            $0.centerY.equalToSuperview()
            $0.top.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-10)
        }
        label.snp.makeConstraints {
            $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(15)
            $0.centerY.equalTo(thumbnailImageView)
        }
    }

    func configure(with image: UIImage?) {
        self.thumbnailImageView.image = image
    }
}
