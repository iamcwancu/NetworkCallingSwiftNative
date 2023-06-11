//
//  UIImageView+Addition.swift
//  NetworkCallingNativeWay
//
//  Created by Shivanshu Verma on 10/06/23.
//

import UIKit
import Kingfisher

extension UIImageView {
    public func setImage(with url: URL?) {
        guard let url else { return }
        let resource = ImageResource(downloadURL: url, cacheKey: url.relativeString)
        kf.indicatorType = .activity
        kf.setImage(with: resource)
    }
}
