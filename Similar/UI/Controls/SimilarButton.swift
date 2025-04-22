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
    
    init(text: LocalizableText, image resource: ImageResource? = nil) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundResourceColor = .backgroundDark
        layer.cornerRadius = 24.height
        title.localizableText = text
        addSubview(title)
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 60.height),
            title.centerYAnchor.constraint(equalTo: centerYAnchor),
            title.centerXAnchor.constraint(equalTo: centerXAnchor, constant: resource == nil ? 0 : 24.width)
        ])
        if let resource = resource {
            let imageView = UIImageView(image: resource.image)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFit
            addSubview(imageView)
            NSLayoutConstraint.activate([
                imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
                imageView.trailingAnchor.constraint(equalTo: title.leadingAnchor, constant: 0),
                imageView.heightAnchor.constraint(equalTo: imageView.heightAnchor),
                imageView.widthAnchor.constraint(equalToConstant: 24.width)
            ])
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
