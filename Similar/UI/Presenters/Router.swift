//
//  Router.swift
//  Similar
//
//  Created by Denis Shkultetskyy on 26.04.2025.
//

import UIKit
import Photos
protocol RouterDelegate: AnyObject {
    func presentView(_ controller: UIViewController)
}

protocol RouterProtocol: AnyObject {
    func showCongratulation(deletedCount: Int) async
    func settingsPromt() async
    func showImage( _ asset: PHAsset) async
}

enum RouterFactory {
    @MainActor
    static func create(_ delegate: RouterDelegate) -> some RouterProtocol {
        let router = Router()
        router.delegate = delegate
        
        return router
    }
}

@MainActor
final class Router: RouterProtocol {
    
    weak var delegate: RouterDelegate?
   
    
    func showCongratulation(deletedCount: Int) async {
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
    
    
    func showImage(_ asset: PHAsset) async {
        
        delegate?.presentView(PhotoViewver(asset))
    }
}
