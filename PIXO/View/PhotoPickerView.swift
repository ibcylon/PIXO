//
//  PhotoPickerView.swift
//  PIXO
//
//  Created by Kanghos on 2022/05/09.
//

import UIKit
import SnapKit

final class PhotoPickerView: UIView {

    var headerView = UIView().then {
        $0.backgroundColor = .white
    }

    let titleLabel = UILabel().then {
        $0.text = "All Photos"
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textColor = .black
        $0.textAlignment = .center
        $0.isUserInteractionEnabled = true
    }

    let transitionButton = UIButton().then {
        $0.tintColor = .systemGray
        $0.setImage(UIImage(systemName: "chevron.up"), for: .normal)
    }

    var collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        collectionView.backgroundColor = .white
        collectionView.register(PhotoPickerCollectionViewCell.self, forCellWithReuseIdentifier: PhotoPickerCollectionViewCell.identifier)
        return collectionView
    }()

    var tableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.backgroundColor = .white
        $0.separatorStyle = .none
        $0.register(PhotoPickerTableViewCell.self, forCellReuseIdentifier: PhotoPickerTableViewCell.identifier)
        $0.isHidden = true
    }

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
        self.backgroundColor = .lightGray
        addView()
        setUpConstraints()
    }

    private func addView() {
        addSubview(collectionView)
        addSubview(tableView)
        addSubview(headerView)
        headerView.addSubview(transitionButton)
        headerView.addSubview(titleLabel)
    }

    private func setUpConstraints() {
        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(safeAreaInsets)
            $0.height.equalTo(100)
        }

        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(15)
        }

        transitionButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(10)
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(1)
            $0.leading.trailing.bottom.equalTo(safeAreaLayoutGuide)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(1)
            $0.leading.trailing.bottom.equalTo(safeAreaLayoutGuide)
        }
    }


}
