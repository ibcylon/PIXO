//
//  PhotoPickerViewController.swift
//  PIXO
//
//  Created by Kanghos on 2022/05/09.
//

import UIKit
import Then
import Photos

final class PhotoPickerViewController: UIViewController {

    var mainView = PhotoPickerView()
    var viewModel = PhotoPickerViewModel()

    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.mainView.collectionView.delegate = self
        self.mainView.collectionView.dataSource = self

        self.mainView.tableView.delegate = self
        self.mainView.tableView.dataSource = self

        setHeader()
        reloadData()
    }

    func reloadData() {
        self.mainView.collectionView.reloadData()
        self.mainView.tableView.reloadData()
        print(viewModel.numberOfRowsInSection)
    }

    func setHeader() {

        self.mainView.transitionButton.addTarget(self, action: #selector(toggleButtonClicked), for: .touchUpInside)

        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(toggleButtonClicked))
        self.mainView.titleLabel.addGestureRecognizer(tap)
    }

    // tableView와 CollectionView 변경
    @objc func toggleButtonClicked() {
        self.mainView.transitionButton.isSelected.toggle()

        let toggle = self.mainView.transitionButton.isSelected

        mainView.collectionView.isHidden = toggle
        mainView.tableView.isHidden = !toggle

        switch toggle {
        case false:
            mainView.transitionButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        case true:
            mainView.transitionButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        }
    }

    func presentStickerScene(_ index: Int) {
        let stickerScene = StickerViewController()
        viewModel.requestImage(index) { image in
            stickerScene.mainView.backgroundImageView.image = image
        }
        stickerScene.modalPresentationStyle = .fullScreen

        self.present(stickerScene, animated: true, completion: nil)
    }
}
extension PhotoPickerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoPickerTableViewCell.identifier, for: indexPath) as? PhotoPickerTableViewCell
        else {
            return PhotoPickerTableViewCell()
        }

        viewModel.requestImage(indexPath.item) { image in
            cell.configure(with: image)
        }
        cell.label.text = viewModel.getResourceName(indexPath.item)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentStickerScene(indexPath.item)
    }

}

extension PhotoPickerViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoPickerCollectionViewCell.identifier, for: indexPath) as? PhotoPickerCollectionViewCell
        else {
            return PhotoPickerCollectionViewCell()
        }
        viewModel.requestImage(indexPath.item) { image in
            cell.configure(with: image)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let itemsPerRow: CGFloat = 3
        let widthPadding = 10 * (itemsPerRow + 1)
        let cellSize = (width - widthPadding) / itemsPerRow

        return CGSize(width: cellSize, height: cellSize)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        presentStickerScene(indexPath.item)
    }
}
