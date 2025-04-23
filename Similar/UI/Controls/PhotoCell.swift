//
//  PhotoCell.swift
//  Similar
//
//  Created by Denis Shkultetskyy on 23.04.2025.
//

import UIKit

final class PhotoCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let imageView = factoryView(UIImageView.self)
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 14.width
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let checkButton = CheckButton()
        
    var model: PhotoViewModel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        addSubview(imageView)
        addSubview(checkButton)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageView.rightAnchor.constraint(equalTo: rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            checkButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -10.width),
            checkButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10.width),
        ])
        checkButton.onCheck { isChecked in
            self.model.isChecked = isChecked
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(_ model: PhotoViewModel) {
        self.model = model
        imageView.image = model.image
        checkButton.isChecked = model.isChecked
        
    }
}

