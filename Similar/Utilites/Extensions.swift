//
//  Extensions.swift
//  Similar
//
//  Created by Denis Shkultetskyy on 22.04.2025.
//

import UIKit

extension UIView {
    
    var backgroundResourceColor: ColorResource? {
        get { nil }
        set {
            guard let newValue else {
                backgroundColor = nil
                
                return
            }
            backgroundColor = UIColor(resource: newValue)
        }
    }
}

extension UILabel {
    var textResourceColor: ColorResource? {
        get { nil }
        set {
            guard let newValue else {
                textColor = nil
                
                return
            }
            
            textColor = UIColor(resource: newValue)
        }
    }
    var localizableText: LocalizableText? {
        get { return nil }
        set {
            text = newValue?.description
        }
    }
}

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
