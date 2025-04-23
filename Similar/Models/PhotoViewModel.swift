//
//  PhotoViewModel.swift
//  Similar
//
//  Created by Denis Shkultetskyy on 23.04.2025.
//

import UIKit

final class PhotoViewModel {
    
    let filePath: String
    var isChecked: Bool = false {
        didSet {
            check()
        }
    }
    
    private var check: EmptyAction
    var image: UIImage {
        ImageResource.congratulations.image
    }
    

    internal init(filePath: String, _ action: @escaping EmptyAction) {
        self.filePath = filePath
        self.check = action
    }
    
}

