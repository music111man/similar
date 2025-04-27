//
//  SimilarViewModel.swift
//  Similar
//
//  Created by Denis Shkultetskyy on 23.04.2025.
//

import UIKit
import Photos

final class SimilarViewModel {
    
    fileprivate let id = UUID().uuidString
    
    var photos = [PhotoViewModel]()
    
    var checkedCount = 0 {
        didSet {
            checkedAction()
            checkedCountAction?(checkedCount)
        }
    }

    private var checkedAction: EmptyAction
    
    private var checkedCountAction: ((Int) -> ())?
    
    init(_ checkedAction: @escaping EmptyAction) {
        self.checkedAction = checkedAction
    }
    
    init(_ assets: [PHAsset], _ checkedAction: @escaping EmptyAction) {
        self.checkedAction = checkedAction
        assets.forEach { createPhoto($0) }
    }

    func onCheck(_ action: @escaping (Int) -> ()) {
        checkedCountAction = action
    }
  
    func createPhoto(_ asset: PHAsset) {
        photos.append(PhotoViewModel(asset: asset, validateCheked))
    }
    
    func validateCheked() {
        checkedCount = photos.count(where: { $0.isChecked })
        
    }
}

extension SimilarViewModel: Equatable, Hashable {
    static func == (lhs: SimilarViewModel, rhs: SimilarViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}

