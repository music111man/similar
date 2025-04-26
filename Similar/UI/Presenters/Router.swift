//
//  Router.swift
//  Similar
//
//  Created by Denis Shkultetskyy on 26.04.2025.
//

import UIKit
protocol RouterDelegate: AnyObject {
    func presentView(_ controller: UIViewController)
}

@MainActor
final class Router {
    
    weak var delegate: RouterDelegate?
    
    func ackToDelete() async -> Bool {
        return await withCheckedContinuation { continuation in
            
            let alert = UIAlertController(title: LocalizableText.titleAlertDelete.description,
                                          message: LocalizableText.subTitleAlertDelete.description,
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: LocalizableText.delete.description, style: .destructive) { _ in
                
                continuation.resume(returning: true)
            })
            alert.addAction(UIAlertAction(title: LocalizableText.cancel.description, style: .cancel) {_ in
                continuation.resume(returning: false)
            })
            delegate?.presentView(alert)
        }
    }
    
    func showCongratulation(deletedCount: Int) {
        self.delegate?.presentView(CongratulationVC(deletedCount: deletedCount))
    }

    func settingsPromt() async {
        return await withCheckedContinuation { continuation in
            let alert = UIAlertController(title: LocalizableText.enableAccess.description,
                                          message: LocalizableText.enableAccessDesc.description,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: LocalizableText.goToSettings.description, style: .destructive) { _ in
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString),
                      UIApplication.shared.canOpenURL(settingsUrl) else {
                    continuation.resume()
                    return
                }
                UIApplication.shared.open(settingsUrl)
                continuation.resume()
            })
            alert.addAction(UIAlertAction(title: LocalizableText.cancel.description, style: .cancel) {_ in
                continuation.resume()
            })
            delegate?.presentView(alert)
        }
    }
    
    func showImage( _ image: UIImage) {
        delegate?.presentView(PhotoViewver(image))
    }
}
