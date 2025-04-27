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
            .replacingOccurrences(of: " %@ ", with: " ")
            .replacingOccurrences(of: "%@ ", with: "")
            .replacingOccurrences(of: " %@", with: "")
    }
    
    func with(value: some CustomStringConvertible) -> String {
        NSLocalizedString(self.rawValue, comment: "").replacingOccurrences(of: "%@", with: "\(value)")
    }
    
    case titleSimilar, deleteSimilars, subTitlePhotos, subTitleSelected, congratulations,
         selectAll, deSelectAll, titleAlertDelete, subTitleAlertDelete, cancel, ok, delete,
         savedUsingCleanup, minutes, reviewMessage, great, youHaveDeleted, searchSilimars,
         deleteSimmilars, goToSettings, enableAccess, enableAccessDesc, searching, deleteError,
         deleteErrorDesc
}
