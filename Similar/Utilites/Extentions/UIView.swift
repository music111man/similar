//
//  UIView.swift
//  Similar
//
//  Created by Denis Shkultetskyy on 27.04.2025.
//

import UIKit

extension UIView {
    static var identifier: String {
        String(describing: self)
    }
    func insetsIn(parent: UIView, top: Int = 0, bottom: Int = 0, left: Int = 0, right: Int = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        parent.addSubview(self)
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: parent.topAnchor, constant: top.height),
            bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -bottom.height),
            leftAnchor.constraint(equalTo: parent.leftAnchor, constant: left.width),
            rightAnchor.constraint(equalTo: parent.rightAnchor, constant: -right.width)
        ])
    }
    
    func insetsInCenter(parent: UIView, offsetX: Int = 0, offsetY: Int = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        parent.addSubview(self)
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: parent.centerXAnchor, constant: offsetX.width),
            centerYAnchor.constraint(equalTo: parent.centerYAnchor, constant: offsetY.height)
        ])
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
    
    var showActivity: Bool {
        get {
            subviews.last is UIActivityIndicatorView
        }
        set {
            if newValue {
                if subviews.last is UIActivityIndicatorView { return }
                let activity = UIActivityIndicatorView()
                activity.style = .large
                activity.color = UIColor.backgroundDark
                activity.insetsInCenter(parent: self)
                activity.startAnimating()
            } else {
                guard let activity = subviews.first(where: { $0 is UIActivityIndicatorView }) as? UIActivityIndicatorView else { return }
                
                activity.removeFromSuperview()
            }
        }
    }
}
