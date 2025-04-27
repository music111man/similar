//
//  PhotoSCell.swift
//  Similar
//
//  Created by Denis Shkultetskyy on 22.04.2025.
//

import UIKit

final class SimilarCell: UITableViewCell {
    
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
        button.textColor = UIColor.textSelected
        button.localizableText = .selectAll
        button.font = UIFont.systemFont(ofSize: 16.height, weight: .medium)
        
        return button
    }()
    
    let collectionView = SimilarCollectionView()
    
    var presenter: SimilarPresenter!

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(button)
        contentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo:  contentView.topAnchor, constant: 20.height),
            titleLabel.leadingAnchor.constraint(equalTo:  contentView.leadingAnchor, constant: 17.width),
            button.firstBaselineAnchor.constraint(equalTo: titleLabel.firstBaselineAnchor),
            button.trailingAnchor.constraint(equalTo:  contentView.trailingAnchor, constant: -23.width),
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5.height),
            collectionView.leadingAnchor.constraint(equalTo:  contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo:  contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo:  contentView.bottomAnchor)
        ])
        
        button.onTap {
            let isCheck = !self.presenter.isAllChecked
            self.presenter.model?.photos.forEach { $0.isChecked = isCheck }
        }
        
        presenter = SimilarPresenter(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ model: SimilarViewModel) {
        presenter.model = model
    }
}

extension SimilarCell: SimilarPresenterDelegate {
    var collection: UICollectionView {
        collectionView
    }
    
    var buttonText: LocalizableText? {
        get {
            button.localizableText
        }
        set {
            button.localizableText = newValue
        }
    }
    
    
}
