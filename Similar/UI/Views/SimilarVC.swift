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
    
    let buttonDelete = SimilarButton(text: .deleteSimilars, image: .deletePhotos, isHidden: true)
    
    let table: UITableView = {
        let table = factoryView(UITableView.self)
        table.backgroundColor = UIColor.backgroundLight
        table.layer.cornerRadius = 20.width
        table.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        table.contentOffset = CGPoint(x: 0, y: 15.height)
        table.allowsSelection = false
        table.separatorStyle = .none
        
        return table
    }()
    let buttonRefresh: UIImageView = {
        let buttonRefresh = factoryView(UIImageView.self)
        
        return buttonRefresh
    }()
    
    let settingsLabel: UILabel = {
        let label = factoryView(UILabel.self)
        label.textColor = UIColor.textLight
        label.font = UIFont.systemFont(ofSize: 11.height, weight: .medium)
        label.textAlignment = .center
        
        return label
    }()
    
    let settings: UIStepper = {
        let stepper = factoryView(UIStepper.self)
        stepper.maximumValue = 90
        stepper.minimumValue = 10
        stepper.stepValue = 5
        stepper.value = UserDefaults.degreeOfSimilarity
        
        return stepper
    }()
    
    var interactor: SimilarInteractorProtocol!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        interactor = SimilarInteractorFactory.create(presenterDelegate: self, routerDelegate: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        view.backgroundColor = UIColor.background
        view.addSubview(titleLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(table)
        view.addSubview(buttonDelete)
        
        
        buttonRefresh.image = UIImage.refresh.withTintColor(UIColor.backgroundLight)
 
        view.addSubview(buttonRefresh)
        view.addSubview(settings)
        view.addSubview(settingsLabel)

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
            
            buttonDelete.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -35.height),
            buttonDelete.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24.width),
            buttonDelete.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24.width),
            buttonRefresh.heightAnchor.constraint(equalTo: buttonRefresh.widthAnchor),
            buttonRefresh.widthAnchor.constraint(equalToConstant: 40.width),
            buttonRefresh.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10.height),
            buttonRefresh.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10.width),
            settings.bottomAnchor.constraint(equalTo: table.topAnchor, constant: -5.height),
            settings.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            settingsLabel.centerXAnchor.constraint(equalTo: settings.centerXAnchor),
            settingsLabel.bottomAnchor.constraint(equalTo: settings.topAnchor, constant: -2.height)
        ])
        
        buttonDelete.onTap {
            Task {
                await self.interactor.deteteSimilar()
            }
        }
        buttonDelete.isHidden = true

        Task {
            await interactor.searchSimilar()
        }
        
        buttonRefresh.onTap {
            Task {
                await self.interactor.searchSimilar()
            }
        }
        
        settings.addTarget(self, action: #selector(changeSettings), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @objc func changeSettings(_ sender: UIStepper) {
        interactor.setSimilar(value: sender.value)
    }
}

extension SimilarVC: StoragePresenterDelegate, RouterDelegate {
    var similarValueTitle: String {
        get {
            settingsLabel.text ?? ""
        }
        set {
            settingsLabel.text = newValue
        }
    }
    
    var activateRefreshButton: Bool {
        get {
            buttonRefresh.isUserInteractionEnabled
        }
        set {
            buttonRefresh.isUserInteractionEnabled = newValue
            buttonRefresh.layer.opacity = newValue ? 1 : 0.5
            settings.isHidden = !newValue
            table.isUserInteractionEnabled = newValue
            table.layer.opacity = newValue ? 1 : 0.7
            view.showActivity = !newValue
        }
    }
    
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
            buttonDelete.text
        }
        set {
            buttonDelete.isHidden = newValue == nil
            buttonDelete.text = newValue
        }
    }
    
}
