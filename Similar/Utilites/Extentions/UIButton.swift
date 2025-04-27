//
//  UIButton.swift
//  Similar
//
//  Created by Denis Shkultetskyy on 27.04.2025.
//

import UIKit

extension UIButton {
    var localizableText: LocalizableText? {
        get { nil }
        set {
            guard let text = newValue?.description else {
                setTitle(nil, for: .normal)
                
                return
            }
            self.text = text
        }
    }
    
    var text: String? {
        get { nil }
        set {
            setTitle(newValue, for: .normal)
        }
    }
    
    var textColor: UIColor? {
        get { nil }
        set {
            guard let newValue else {
                setTitleColor(nil, for: .normal)
                
                return
            }
            setTitleColor(newValue, for: .normal)
        }
    }
    
    var image: UIImage? {
        get { return nil }
        set {
            guard let newValue else {
                setImage(nil, for: .normal)
                
                return
            }
            setImage(newValue, for: .normal)
        }
    }
    var font: UIFont? {
        get { nil }
        set {
            guard let newValue else {
                titleLabel?.font = nil
                
                return
            }
            titleLabel?.font = newValue
        }
    }
}
