//
//  PhotoCell.swift
//  Similar
//
//  Created by Denis Shkultetskyy on 23.04.2025.
//

import UIKit
import Photos

final class PhotoCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let imageView = factoryView(UIImageView.self)
        imageView.backgroundColor = .backPhoto
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 14.width
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.backPhoto.cgColor
        return imageView
    }()
    
    let checkButton: UIImageView = {
        let checkButton = UIImageView()
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        checkButton.contentMode = .scaleToFill
        checkButton.image = UIImage.unCheck
        checkButton.layer.cornerRadius = 10.width
        checkButton.layer.borderWidth = 1
        checkButton.layer.borderColor = UIColor.backgroundDark.cgColor
        NSLayoutConstraint.activate([
            checkButton.heightAnchor.constraint(equalTo: checkButton.widthAnchor),
            checkButton.widthAnchor.constraint(equalToConstant: 30.width)
        ])
        
        return checkButton
    }()
        
    var model: PhotoViewModel!
    var showImageAction: ((PHAsset) -> ())?
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        imageView.insetsIn(parent: contentView)
        contentView.addSubview(checkButton)
        
        NSLayoutConstraint.activate([
            checkButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10.width),
            checkButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.width),
        ])
        checkButton.onTap {
            self.model.isChecked.toggle()
        }
        imageView.onTap {
            self.showImageAction?(self.model.asset)
        }
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(_ model: PhotoViewModel, _ action: @escaping (PHAsset) -> ()) {
        self.model = model
        showImageAction = action
        
        model.onChecked { checked in
            self.checkButton.image = checked ? UIImage.check : UIImage.unCheck
        }
        checkButton.image = model.isChecked ? UIImage.check : UIImage.unCheck
        Task {
            imageView.image = await model.image
        }
    }
}

