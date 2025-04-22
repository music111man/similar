//
//  SubCongratulationView.swift
//  Similar
//
//  Created by Denis Shkultetskyy on 22.04.2025.
//

import UIKit

final class SubCongratulationView: UIView {
    
    init(image: UIImage, text: String, selected: String) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        let textLabel = factoryView(UILabel.self)
        textLabel.numberOfLines = 0
        textLabel.lineBreakMode = .byWordWrapping
        
        let attributString = NSMutableAttributedString(string: text, attributes: [
            .foregroundColor: UIColor(resource: .textDark),
            .font: UIFont.systemFont(ofSize: 20.height, weight: .regular)
        ])
        let range = attributString.mutableString.range(of: selected)
        attributString.addAttribute(.foregroundColor, value: UIColor(resource: .textSelected), range: range)
        attributString.addAttribute(.font, value: UIFont.systemFont(ofSize: 20.height, weight: .bold), range: range)
        textLabel.attributedText = attributString
        let imageView = factoryView(UIImageView.self)
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
        addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 40.width),
            textLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12.width),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            textLabel.topAnchor.constraint(equalTo: topAnchor),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
