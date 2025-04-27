//
//  SimilarButton.swift
//  Similar
//
//  Created by Denis Shkultetskyy on 22.04.2025.
//

import UIKit

final class SimilarButton: UIView {
    let title: UILabel = {
        let title = factoryView(UILabel.self)
        title.textResourceColor = .textLight
        title.font = UIFont.systemFont(ofSize: 20.height, weight: .semibold)
        
        return title
    }()
    
    var text: String? {
        get {
            title.text
        }
        set {
            title.text = newValue
        }
    }
    
    private let transformHide: CGAffineTransform = .init(scaleX: 0.01, y: 0.01)
    
    init(text: LocalizableText, image: UIImage? = nil, isHidden: Bool = false) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.backgroundDark
        layer.cornerRadius = 24.height
        title.localizableText = text
        title.insetsInCenter(parent: self, offsetX: (image == nil ? 0 : 24))
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 60.height),
        ])
        guard let image = image else { return }
        
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.trailingAnchor.constraint(equalTo: title.leadingAnchor, constant: 0),
            imageView.heightAnchor.constraint(equalTo: imageView.heightAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 24.width)
        ])
        super.isHidden = isHidden
        transform = isHidden ? transformHide : .identity
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHidden: Bool {
        get { super.isHidden }
        set {
            if newValue {
                if !super.isHidden {
                    UIView.animate(withDuration: 0.3) {
                        self.transform = .init(scaleX: 0.01, y: 0.01)
                    } completion: { _ in
                        super.isHidden = true
                    }
                }
                
                return
            }
            if super.isHidden {
                super.isHidden = false
                self.transform = .init(scaleX: 0.01, y: 0.01)
                UIView.animate(withDuration: 0.3) {
                    self.transform = .identity
                }
            }
        }
    }
}
