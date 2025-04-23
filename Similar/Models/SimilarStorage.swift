//
//  SimilarStorage.swift
//  Similar
//
//  Created by Denis Shkultetskyy on 23.04.2025.
//

import UIKit

final class SimilarStorage {
    
    var similarCollection = [SimilarViewModel]()
    var action: ((Int) -> ())?
    
    init() {
        for i in (0...Int.random(in: 9...20)) {
            var files = Array(repeating: "\(i)", count: Int.random(in: 2...6))
            add(files)
        }
    }
    
    func add(_ files: [String]) {
        similarCollection.append(SimilarViewModel(files) {
            let count = self.similarCollection.count(where: { $0.checkedCount > 0 })
            self.action?(count)
        })
    }
    
    func onCheck(_ action: @escaping (Int) -> ()) {
        self.action = action
    }
}
