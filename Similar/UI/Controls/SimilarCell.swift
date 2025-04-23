//
//  PhotoSCell.swift
//  Similar
//
//  Created by Denis Shkultetskyy on 22.04.2025.
//

import UIKit
import Combine

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
        button.textColor = .background
        button.localizableText = .selectAll
        button.font = UIFont.systemFont(ofSize: 16.height, weight: .medium)
        
        return button
    }()
    
    let collectionView = SimilarCollectionView()
    
    var presenter: SimilarPresenter!
    var cancelable: AnyCancellable?
    
    var model: SimilarViewModel!
    var isAllChecked: Bool {
        model.checkedCount == model.photos.count
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(titleLabel)
        addSubview(button)
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20.height),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 17.width),
            button.firstBaselineAnchor.constraint(equalTo: titleLabel.firstBaselineAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -23.width),
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5.height),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        button.onTap {
            let isCheck = !self.isAllChecked
            self.model.photos.forEach { $0.isChecked = isCheck }
        }
        
        presenter = SimilarPresenter(collectionView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        cancelable?.cancel()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cancelable?.cancel()
    }
    
    func configure(_ model: SimilarViewModel) {
        self.model = model
        
        cancelable = model.$checkedCount.sink { count in
            self.button.localizableText = self.isAllChecked ? .deSelectAll : .selectAll
        }
        
        
    }
}

