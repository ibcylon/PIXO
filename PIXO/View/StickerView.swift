//
//  StickerView.swift
//  PIXO
//
//  Created by Kanghos on 2022/05/12.
//

import UIKit
import SnapKit

final class StickerView: UIView {

    var headerView = UIView().then {
        $0.backgroundColor = .white
    }

    var dismissButton = UIButton().then {
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        $0.tintColor = .black
    }

    var stickerImageView = UIImageView().then {
        $0.isHidden = true
        $0.clipsToBounds = true
        $0.backgroundColor = .clear
    }

    var overlayButton = UIButton().then {
        $0.clipsToBounds = true
        $0.setTitle("Overlay", for: .normal)
        $0.layer.cornerRadius = Constant.cellCornerRadius * 2
        $0.setTitleColor(.white, for: .normal)
        $0.setTitleColor(.systemGray, for: .highlighted)
        $0.backgroundColor = .black
    }

    var backgroundImageView = UIImageView().then {
        $0.clipsToBounds = true
        $0.backgroundColor = .white
        $0.contentMode = .scaleAspectFill
    }

    var collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 3
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 5)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        collectionView.backgroundColor = .white
        collectionView.register(StickerCollectionViewCell.self, forCellWithReuseIdentifier: StickerCollectionViewCell.identifier)
        return collectionView
    }()

    // Code로 생성
    override init(frame: CGRect) {
        super.init(frame: frame)

        setUpUI()
        collectionView.dataSource = self
    }

    // Bundle로 생성
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpUI() {
        backgroundColor = .white
        addView()
        setUpConstraints()
    }

    private func addView() {
        addSubview(backgroundImageView)
        addSubview(collectionView)
        addSubview(headerView)
        backgroundImageView.addSubview(stickerImageView)
        headerView.addSubview(dismissButton)
        headerView.addSubview(overlayButton)

    }

    private func setUpConstraints() {
        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(safeAreaInsets)
            $0.height.equalTo(100)
        }

        dismissButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(30)
            $0.bottom.equalToSuperview().inset(15)
        }
        overlayButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalTo(dismissButton)
            $0.width.equalTo(100)
        }
        stickerImageView.snp.makeConstraints {
            $0.center.equalTo(backgroundImageView)
            $0.size.equalTo(UIScreen.main.bounds.height / 3)
        }

        collectionView.snp.makeConstraints {
            $0.height.equalTo(UIScreen.main.bounds.height / 5)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
        backgroundImageView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalTo(collectionView.snp.top)
        }
    }
}

extension StickerView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 14
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StickerCollectionViewCell.identifier, for: indexPath) as? StickerCollectionViewCell
        else {
            return StickerCollectionViewCell()
        }
        cell.thumbnailImageView.image = UIImage(named: "\(indexPath.item + 1)")

        return cell
    }
}
