//
//  SimilarView.swift
//  Similar
//
//  Created by Denis Shkultetskyy on 22.04.2025.
//

import UIKit

final class SimilarVC: UIViewController {
    
    
    let titleLabel: UILabel = {
        let title = factoryView(UILabel.self)
        title.textResourceColor = .textLight
        title.localizableText = .titleSimilar
        title.textAlignment = .left
        title.font = UIFont.systemFont(ofSize: 28.height, weight: .bold)
        
        return title
    }()
    
    let subTitleLabel: UILabel = {
        let title = factoryView(UILabel.self)
        title.textResourceColor = .textLight
        title.textAlignment = .left
        title.font = UIFont.systemFont(ofSize: 14.height, weight: .bold)
        
        return title
    }()
    
    let button = SimilarButton(text: .deleteSimilars, image: .deletePhotos, isHidden: true)
    
    let table: UITableView = {
        let table = factoryView(UITableView.self)
        table.backgroundResourceColor = .backgroundLight
        table.layer.cornerRadius = 20.width
        table.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        table.contentOffset = CGPoint(x: 0, y: 15.height)
        table.allowsSelection = false
        
        return table
    }()
    
    var similarManager: SimilarManagerProtocol!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        similarManager = SimilarManagerFactory.createManager(presenterDelegate: self, routerDelegate: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        view.backgroundResourceColor = .background
        view.addSubview(titleLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(table)
        view.addSubview(button)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50.height),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.width),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.width),
            
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2.height),
            subTitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subTitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            table.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 7.height),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -35.height),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24.width),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24.width)
        ])
        
        button.onTap {
            Task {
                await self.similarManager.deteteSimilar()
            }
        }
        button.isHidden = true
        
        Task {
            await similarManager.searchSimilar()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}

extension SimilarVC: StoragePresenterDelegate, RouterDelegate {
    func presentView(_ controller: UIViewController) {
        present(controller, animated: true)
    }
    
    var topCountMessage: String {
        get {
            subTitleLabel.text ?? ""
        }
        set {
            subTitleLabel.text = newValue
        }
    }
    
    var checkedCountMessage: String? {
        get {
            button.text
        }
        set {
            button.isHidden = newValue == nil
            button.text = newValue
        }
    }
    
}
