//
//  PhotoViewver.swift
//  Similar
//
//  Created by Denis Shkultetskyy on 25.04.2025.
//

import UIKit
import Photos

final class PhotoViewver: UIViewController {
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    let asset: PHAsset
    
    init(_ asset: PHAsset) {
        self.asset = asset
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .fullScreen
        modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.background
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
        Task {
            imageView.showActivity = true
            imageView.image = await asset.detailsImage
            imageView.showActivity = false
        }

    }
    
}
