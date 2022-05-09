//
//  PhotoPickerView.swift
//  PIXO
//
//  Created by Kanghos on 2022/05/09.
//

import UIKit
import SnapKit

final class PickerCollectionView: UIView {

    var collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .white
        return collectionView
    }()

    // Code로 생성
    override init(frame: CGRect) {
        super.init(frame: frame)

        setUpUI()
    }

    // Bundle로 생성
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpUI() {
        addView()
        setUpConstraints()
    }

    private func addView() {
        addSubview(collectionView)
    }

    private func setUpConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }


}
