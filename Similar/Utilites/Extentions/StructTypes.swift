//
//  Int.swift
//  Similar
//
//  Created by Denis Shkultetskyy on 27.04.2025.
//

import UIKit

fileprivate let desighScreenWidth: CGFloat = 393
fileprivate let desighScreenHeight: CGFloat = 852

extension Int {
    var width: CGFloat {
        UIScreen.main.bounds.width * (CGFloat(self) / desighScreenWidth)
    }
    var height: CGFloat {
        UIScreen.main.bounds.height * (CGFloat(self) / desighScreenHeight)
    }
}

extension Date {

    var withOutTime: Date? {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        let date = Calendar.current.date(from: components)
        
        return date
    }

}

extension UserDefaults {
    static var degreeOfSimilarity: Double {
        get { (UserDefaults.standard.value(forKey: "degreeOfSimilarity") as? Double) ?? 70.0 }
        set {
            UserDefaults.standard.set(newValue, forKey: "degreeOfSimilarity")
        }
    }
}

extension CIImage {
    var creatingExifDate: String? {
        guard let exif = self.properties["{Exif}"] as? [String: Any],
              let dateString = exif["DateTimeOriginal"] as? String else { return nil }
        
        return dateString
    }
}
