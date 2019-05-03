//
//  extensions.swift
//  MovieApp
//
//  Created by user143649 on 4/18/19.
//  Copyright © 2019 user143649. All rights reserved.
//

import UIKit

extension UICollectionView {
    //This extension helps to minimise the deque reusable cell call by making use of generics
    func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView {
        register(T.self, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
        }
        
        
        func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
            guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
                fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
            }
            
            return cell
}

}
