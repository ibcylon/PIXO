//
//  UIView+Extension.swift
//  PIXO
//
//  Created by Kanghos on 2022/05/12.
//

import UIKit

// https://ios-development.tistory.com/237
// UIView를 이미지로 저장하기

extension UIView {
    func transfromToImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0.0)
        defer {
            UIGraphicsEndImageContext()
        }
        if let context = UIGraphicsGetCurrentContext() {
            layer.render(in: context)
            return UIGraphicsGetImageFromCurrentImageContext()
        }
        return nil
    }
}
