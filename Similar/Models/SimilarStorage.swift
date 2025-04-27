//
//  SimilarStorage.swift
//  Similar
//
//  Created by Denis Shkultetskyy on 23.04.2025.
//

import UIKit
import Photos

final class SimilarStorage {
    
    var similarCollection = [SimilarViewModel]()
    var checkedCount: Int {
        self.similarCollection.reduce(0, { partialResult, model in
            partialResult + model.checkedCount
        })
    }
    
    var action: ((Int) -> ())?
    
    init(_ set: Set<[PHAsset]>) {
        set.forEach {
            similarCollection.append(SimilarViewModel($0) {
                self.action?(self.checkedCount)
            })
        }
    }
    
    var checketAssets: [PHAsset] {
        self.similarCollection.flatMap{ $0.photos }
            .filter{ $0.isChecked }
            .map{ $0.asset }
    }
    
    func onCheck(_ action: @escaping (Int) -> ()) {
        self.action = action
    }
}
