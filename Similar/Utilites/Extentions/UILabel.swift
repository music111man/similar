//
//  UILabel.swift
//  Similar
//
//  Created by Denis Shkultetskyy on 27.04.2025.
//

import UIKit

extension UILabel {
    
    var localizableText: LocalizableText? {
        get { return nil }
        set {
            text = newValue?.description
        }
    }
}
