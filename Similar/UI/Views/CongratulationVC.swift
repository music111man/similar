//
//  CongratulationVC.swift
//  Similar
//
//  Created by Denis Shkultetskyy on 22.04.2025.
//

import UIKit

final class CongratulationVC: UIViewController {

    let image: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.image = UIImage.congratulations
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalTo: view.widthAnchor),
            view.widthAnchor.constraint(equalToConstant: 230.width)
        ])
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = UIColor.textDark
        title.localizableText = .congratulations
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 36.height, weight: .bold)
        
        return title
    }()
    
    let subLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = UIColor.textGray
        title.localizableText = .reviewMessage
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 16.height, weight: .medium)
        title.numberOfLines = 0
        title.lineBreakMode = .byWordWrapping
        
        return title
    }()
 
    let deletedCount: Int
    
    init(deletedCount: Int) {
        self.deletedCount = deletedCount
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .fullScreen
        modalTransitionStyle = .flipHorizontal
    }
    
    required init?(coder: NSCoder) {
        deletedCount = 0
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.backgroundLight
        view.addSubview(image)
        view.addSubview(titleLabel)
        
        let deleteCountText = LocalizableText.subTitlePhotos.with(value: deletedCount)
        let deleteText = "\(LocalizableText.youHaveDeleted.description)\(deleteCountText)"
        let subDeleteView = SubCongratulationView(image: UIImage.starts, text: deleteText, selected: deleteCountText)
        view.addSubview(subDeleteView)
        
        let saveCountText = LocalizableText.minutes.with(value: deletedCount)
        let saveText = LocalizableText.savedUsingCleanup.with(value: saveCountText)
        let subSaveView = SubCongratulationView(image: UIImage.saved, text: saveText, selected: saveCountText)
        view.addSubview(subSaveView)
        
        view.addSubview(subLabel)
        
        let button = SimilarButton(text: .great)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5.height),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: image.bottomAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            subDeleteView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 47.height),
            subDeleteView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 63.width),
            subDeleteView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -63.width),
            
            subSaveView.topAnchor.constraint(equalTo: subDeleteView.bottomAnchor, constant: 57.height),
            subSaveView.leadingAnchor.constraint(equalTo: subDeleteView.leadingAnchor),
            subSaveView.trailingAnchor.constraint(equalTo: subDeleteView.trailingAnchor),
            
            subLabel.topAnchor.constraint(equalTo: subSaveView.bottomAnchor, constant: 57.height),
            subLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30.width),
            subLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30.width),
            
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -63.height),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24.width),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24.width)
        ])
        
        button.onTap {
            self.dismiss(animated: true)
        }
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animate(withDuration: 1, delay: 0.3, options: [.repeat, .autoreverse]) {
            self.image.transform = .init(scaleX: 1.2, y: 1.2)
        }
    }
    
    private func subTitle(text: String, seklected: String) -> UILabel {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = UIColor.textDark
        title.localizableText = .congratulations
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 20.height, weight: .regular)
        title.numberOfLines = 0
        title.lineBreakMode = .byWordWrapping
        
        return title
    }
}
