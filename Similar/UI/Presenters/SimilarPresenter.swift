//
//  SimilarPresenter.swift
//  Similar
//
//  Created by Denis Shkultetskyy on 23.04.2025.
//

import UIKit

protocol SimilarPresenterDelegate: AnyObject {
    var collection: UICollectionView { get }
    var buttonText: LocalizableText? { get set }
}

final class SimilarPresenter: NSObject {
    
    weak var delegate: SimilarPresenterDelegate?
    
    var model: SimilarViewModel? {
        didSet {
            model?.onCheck { count in
                self.delegate?.buttonText = self.isAllChecked ? .deSelectAll : .selectAll
            }
            delegate?.collection.reloadData()
        }
    }
    private var tapAction: ((UIImage) ->())?
    
    var isAllChecked: Bool {
        guard let model else { return false }
        
        return model.checkedCount == model.photos.count
    }
    
    init(_ delegate: SimilarPresenterDelegate) {
        super.init()
        self.delegate = delegate
        self.delegate?.collection.delegate = self
        self.delegate?.collection.dataSource = self
        self.delegate?.collection.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.identifier)
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
            cell.configure(photo) { image in
                self.tapAction?(image)
            }
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
