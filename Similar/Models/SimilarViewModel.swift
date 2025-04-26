//
//  SimilarViewModel.swift
//  Similar
//
//  Created by Denis Shkultetskyy on 23.04.2025.
//

import UIKit

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
    
    init(_ files: [String], _ checkedAction: @escaping EmptyAction) {
        self.checkedAction = checkedAction
        files.forEach { createPhoto($0) }
    }

    func onCheck(_ action: @escaping (Int) -> ()) {
        checkedCountAction = action
    }
  
    func createPhoto(_ path: String) {
        photos.append(PhotoViewModel(filePath: path, validateCheked))
    }
    
    func validateCheked() {
        checkedCount = photos.count(where: { $0.isChecked })
        
    }
}

