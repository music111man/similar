//
//  SimilarPresenter.swift
//  Similar
//
//  Created by Denis Shkultetskyy on 23.04.2025.
//

import UIKit

final class SimilarPresenter: NSObject {
    
    var model: SimilarViewModel?
    
    private var tapAction: ((UIImage) ->())?
    
    init(_ collectionView: UICollectionView) {
        super.init()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.identifier)
    }
    
    func onTapImage(_ action: @escaping (UIImage) -> ()) {
        tapAction = action
    }
    

}

extension SimilarPresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model?.photos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier, for: indexPath) as! PhotoCell
        if let photo = model?.photos[indexPath.row] {
            cell.configure(photo)
        }
        
        return cell
    }
}

extension SimilarPresenter: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let image = model?.photos[indexPath.row].image else { return }
        
        tapAction?(image)
    }
}
