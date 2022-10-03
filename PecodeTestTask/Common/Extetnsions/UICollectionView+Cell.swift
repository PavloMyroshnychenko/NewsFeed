//
//  UICollectionView+Cell.swift
//  PecodeTestTask
//
//  Created by Pavlo Myroshnychenko on 30.09.2022.
//

import UIKit

extension UICollectionView {
    func dequeueCell<T: UICollectionViewCell>(_ type: T.Type, indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(
            withReuseIdentifier: type.identifier,
            for: indexPath) as! T
    }

    func registerCell<T: UICollectionViewCell>( _ type: T.Type) {
        self.register(type.nib, forCellWithReuseIdentifier: type.identifier)
    }

    func registerHeader<T: UICollectionReusableView>(_ type: T.Type) {
        self.register(
            type.nib,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: type.identifier)
    }

    func registerFooter<T: UICollectionReusableView>(_ type: T.Type) {
        self.register(
            type.nib,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: type.identifier)
    }
}
