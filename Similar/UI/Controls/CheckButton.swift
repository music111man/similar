//
//  CheckButton.swift
//  Similar
//
//  Created by Denis Shkultetskyy on 23.04.2025.
//

import UIKit

final class CheckButton: UIImageView {
    
    var isChecked = false {
        didSet {
            image = isChecked ? ImageResource.check.image : ImageResource.unCheck.image
            checkAction?(isChecked)
        }
    }
    
    var checkAction: ((Bool) -> ())?
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .black
        contentMode = .scaleToFill
        image = ImageResource.unCheck.image
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalTo: widthAnchor),
            widthAnchor.constraint(equalToConstant: 30.width)
        ])
        onTap {
            self.isChecked.toggle()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func onCheck(_ action: @escaping (Bool) -> ()) {
        checkAction = action
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return bounds.insetBy(dx: -bounds.width / 2, dy: -bounds.height / 2).contains(point)
    }
}

