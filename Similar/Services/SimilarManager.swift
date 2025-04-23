//
//  SimilarManager.swift
//  Similar
//
//  Created by Denis Shkultetskyy on 23.04.2025.
//

import Foundation
import Combine

final class SimilarManager {
    
    let presenter: StoragePresenter
    
    @MainActor init() {
        presenter = StoragePresenter()
    }
    
    func showSimilar() async {
        try? await Task.sleep(nanoseconds: 3_000_000_000)
        await MainActor.run {
            presenter.storage = SimilarStorage()
        }
        
    }
    
    func deteteSimilar() async -> Bool {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        return true
    }
}
