//
//  SimilarStorage.swift
//  Similar
//
//  Created by Denis Shkultetskyy on 23.04.2025.
//

import UIKit

final class SimilarStorage {
    
    var similarCollection = [SimilarViewModel]()
    var checkedCount: Int {
        self.similarCollection.reduce(0, { partialResult, model in
            partialResult + model.checkedCount
        })
    }
    
    var action: ((Int) -> ())?
    
    init() {
        for i in (0...Int.random(in: 9...20)) {
            let files = Array(repeating: "\(i)", count: Int.random(in: 2...6))
            add(files)
        }
    }
    
    func add(_ files: [String]) {
        similarCollection.append(SimilarViewModel(files) {
            self.action?(self.checkedCount)
        })
    }
    
    func onCheck(_ action: @escaping (Int) -> ()) {
        self.action = action
    }
}
