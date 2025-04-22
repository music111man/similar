//
//  PhotoSCell.swift
//  Similar
//
//  Created by Denis Shkultetskyy on 22.04.2025.
//

import UIKit

final class PhotoCell: UITableViewCell {
    
    let titleLabel: UILabel = {
        let title = factoryView(UILabel.self)
        title.textResourceColor = .textDark
        title.localizableText = .titleSimilar
        title.textAlignment = .left
        title.font = UIFont.systemFont(ofSize: 24.height, weight: .bold)
        
        return title
    }()
    
    let button: UIButton = {
        let button = factoryView(UIButton.self)
        button.textColor = .background
        button.image = .deletePhotos
        button.localizableText = .selectAll
        button.heightAnchor.constraint(equalToConstant: 60.height).isActive = true
        button.layer.cornerRadius = 60.height / 2
        button.font = UIFont.systemFont(ofSize: 16.height, weight: .medium)
        
        return button
    }()
}
