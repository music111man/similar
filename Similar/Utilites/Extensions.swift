//
//  Extensions.swift
//  Similar
//
//  Created by Denis Shkultetskyy on 22.04.2025.
//

import UIKit

extension UIView {
    static var identifier: String {
        String(describing: self)
    }
    
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
    
    func onTap(animationDuration: TimeInterval = 0.1, _ action: @escaping() -> Void) {
        let tapGesture = GestureRecognizerForHandleTapOnView(target: self, action: #selector(makeTapForGestureForHandler(_:)))
        tapGesture.duration = animationDuration
        
        tapGesture.action = action
        isUserInteractionEnabled = true
        addGestureRecognizer(tapGesture)
    }
    
    final private class GestureRecognizerForHandleTapOnView:  UITapGestureRecognizer {
        var action: (() -> Void)?
        var duration: TimeInterval = 0.3
    }
   
    @objc
    private func makeTapForGestureForHandler(_ sender: GestureRecognizerForHandleTapOnView) {
        if sender.duration == 0 {
            sender.action?()
            return
        }
       
        UIView.animate(withDuration: sender.duration) {
            self.layer.opacity = 0.8
            self.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
        } completion: { _ in
            UIView.animate(withDuration: sender.duration)  {
                sender.action?()
                self.layer.opacity = 1
                self.transform = .identity
            }
        }
        
    }
}

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
    var textColor: ColorResource? {
        get { nil }
        set {
            guard let newValue else {
                setTitleColor(nil, for: .normal)
                
                return
            }
            setTitleColor(nil, for: .normal)
        }
    }
    
    var image: ImageResource? {
        get { return nil }
        set {
            guard let newValue else {
                setImage(nil, for: .normal)
                
                return
            }
            setImage(newValue.image, for: .normal)
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

extension ColorResource {
    var color: UIColor {
        UIColor(resource: self)
    }
    var cgColor: CGColor {
        UIColor(resource: self).cgColor
    }
    
}
extension ImageResource {
    var image: UIImage {
        UIImage(resource: self)
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

func factoryView<UI: UIView>(_ typeOff: UI.Type = UIView.self) -> UI {
    let element = UI()
    element.translatesAutoresizingMaskIntoConstraints = false
    
    return element
}

