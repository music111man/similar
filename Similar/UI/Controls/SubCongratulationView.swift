//
//  SubCongratulationView.swift
//  Similar
//
//  Created by Denis Shkultetskyy on 22.04.2025.
//

import UIKit

final class SubCongratulationView: UIView {
    let imageView: UIImageView
    var animate = false
    init(image: UIImage, text: String, selected: String) {
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if animate { return }
        animate = true
        UIView.animate(withDuration: TimeInterval.random(in: 0.3...1), delay: TimeInterval.random(in: 0.3...0.5), options: [.repeat, .autoreverse]) {
            self.imageView.transform = .init(scaleX: 1.1, y: 1.1)
        }
    }
}
