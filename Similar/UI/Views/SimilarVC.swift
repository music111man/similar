//
//  SimilarView.swift
//  Similar
//
//  Created by Denis Shkultetskyy on 22.04.2025.
//

import UIKit

final class SimilarVC: UIViewController {
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .white
        title.localizableText = .titleSimilar
        title.textAlignment = .left
        title.font = UIFont.systemFont(ofSize: 28.height, weight: .bold)
        
        return title
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundResourceColor = .background
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50.height),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.width),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.width)
        ])
    }
}
