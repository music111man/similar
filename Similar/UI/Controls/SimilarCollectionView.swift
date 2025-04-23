//
//  SimilarCollectionView.swift
//  Similar
//
//  Created by Denis Shkultetskyy on 23.04.2025.
//

import UIKit

class SimilarCollectionView: UICollectionView {

    init() {
        super.init(frame: .zero, collectionViewLayout: Self.collectionViewLayout)
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 215.height).isActive = true
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private static var collectionViewLayout: UICollectionViewLayout {
        
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .absolute(183.width), heightDimension: .fractionalWidth(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension:  .absolute(183.width), heightDimension: .fractionalWidth(1)), subitem: item, count: 1)
        group.interItemSpacing = .fixed(5.width)
        
        let section = NSCollectionLayoutSection(group: group)
        //section.interGroupSpacing = 5.width
        let conf = UICollectionViewCompositionalLayoutConfiguration()
        conf.scrollDirection = .horizontal
    
        return UICollectionViewCompositionalLayout(section: section, configuration: conf)
        
    }
}
