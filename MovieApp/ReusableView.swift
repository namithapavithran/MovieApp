//
//  ReusableView.swift
//  MovieApp
//
//  Created by user143649 on 4/18/19.
//  Copyright © 2019 user143649. All rights reserved.
//

import UIKit

protocol ReusableView: class {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReusableView {}
