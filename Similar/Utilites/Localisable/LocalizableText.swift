//
//  LocalizedText.swift
//  Similar
//
//  Created by Denis Shkultetskyy on 22.04.2025.
//

import UIKit


enum LocalizableText: String, CustomStringConvertible {
    
    var description: String {
        NSLocalizedString(self.rawValue, comment: "")
    }
    
    case titleSimilar
}
