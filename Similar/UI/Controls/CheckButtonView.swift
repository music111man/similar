//
//  CheckButtonView.swift
//  Similar
//
//  Created by Denis Shkultetskyy on 27.04.2025.
//

import UIKit

final class CheckButtonView: UIImageView {
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleToFill
        image = UIImage.unCheck
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalTo: widthAnchor),
            widthAnchor.constraint(equalToConstant: 30.width)
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        bounds.insetBy(dx: -bounds.width / 2, dy: -bounds.height / 2).contains(point)
    }
}
