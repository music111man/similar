//
//  Extensions.swift
//  Similar
//
//  Created by Denis Shkultetskyy on 22.04.2025.
//

import UIKit
import Photos

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
    
    var shadowPathLine: CGFloat? {
        get { nil }
        set {
            guard let newValue else { return }
            let shadowPath = CGMutablePath()
            shadowPath.move(to: CGPoint(x: layer.shadowRadius,
                                        y: -newValue))
            shadowPath.addLine(to: CGPoint(x: layer.shadowRadius,
                                           y: newValue))
            shadowPath.addLine(to: CGPoint(x: layer.bounds.width - layer.shadowRadius,
                                           y: newValue))
            shadowPath.addLine(to: CGPoint(x: layer.bounds.width - layer.shadowRadius,
                                           y: -newValue))
                 
            shadowPath.addQuadCurve(to: CGPoint(x: layer.shadowRadius,
                                                y: -newValue),
                                    control: CGPoint(x: layer.bounds.width / 2,
                                                     y: newValue))
                 
            layer.shadowPath = shadowPath
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

fileprivate let previewOptions: PHImageRequestOptions = {
    let options = PHImageRequestOptions()
    options.resizeMode = .fast
    options.isNetworkAccessAllowed = false
    options.deliveryMode = PHImageRequestOptionsDeliveryMode.highQualityFormat
    options.isSynchronous = false
    
    return options
}()

fileprivate let detailsOptions: PHImageRequestOptions = {
    let options = PHImageRequestOptions()
    options.resizeMode = .none
    options.isNetworkAccessAllowed = false
    options.deliveryMode = PHImageRequestOptionsDeliveryMode.highQualityFormat
    options.isSynchronous = false
    
    return options
}()
let screenBounds = UIScreen.main.bounds
extension PHAsset {
    var previewImage: UIImage? {
        get async {
            return await withCheckedContinuation { continuation in
                PHImageManager.default().requestImage(for: self,
                                                      targetSize: CGSize(width: 183.width, height: 215.height),
                                                      contentMode: PHImageContentMode.aspectFill,
                                                      options: previewOptions) { image, _ in
                    continuation.resume(returning: image)
                }
            }
        }
    }
    
    var detailsImage: UIImage? {
        get async {
            return await withCheckedContinuation { continuation in
                PHImageManager.default().requestImage(for: self,
                                                      targetSize: screenBounds.size,
                                                      contentMode: PHImageContentMode.aspectFit,
                                                      options: detailsOptions) { image, _ in
                    continuation.resume(returning: image)
                }
            }

        }
    }
}



func factoryView<UI: UIView>(_ typeOff: UI.Type = UIView.self) -> UI {
    let element = UI()
    element.translatesAutoresizingMaskIntoConstraints = false
    
    return element
}

//com.music111man.similar
//com.bokmal.coiler

