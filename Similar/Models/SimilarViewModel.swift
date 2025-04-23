//
//  SimilarViewModel.swift
//  Similar
//
//  Created by Denis Shkultetskyy on 23.04.2025.
//

import UIKit
import Combine

final class SimilarViewModel {
    
    fileprivate let id = UUID().uuidString
    
    var photos = [PhotoViewModel]()
    
    @Published var checkedCount = 0

    private var checkedAction: EmptyAction
    
    
    init(_ checkedAction: @escaping EmptyAction) {
        self.checkedAction = checkedAction
    }
    
    init(_ files: [String], _ checkedAction: @escaping EmptyAction) {
        self.checkedAction = checkedAction
        files.forEach { createPhoto($0) }
    }
    
    func createPhoto(_ path: String) {
        photos.append(PhotoViewModel(filePath: path, validateCheked))
    }
    
    func validateCheked() {
        checkedCount = photos.count(where: { $0.isChecked })
        checkedAction()
    }
}

