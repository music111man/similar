//
//  PhotoViewver.swift
//  Similar
//
//  Created by Denis Shkultetskyy on 25.04.2025.
//

import UIKit

final class PhotoViewver: UIViewController {
    
    let imageView: UIImageView = {
        let image = factoryView(UIImageView.self)
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    init(_ image: UIImage) {
        super.init(nibName: nil, bundle: nil)
        imageView.image = image
        modalPresentationStyle = .fullScreen
        modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundResourceColor = .background
        imageView.insetsIn(parent: view)
        let button = UIButton(type: .close)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalTo: button.widthAnchor),
            button.widthAnchor.constraint(equalToConstant: 30.width),
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            button.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10.width)
        ])
        
        button.onTap {
            self.dismiss(animated: true)
        }
    }
}
