//
//  PhotoViewModel.swift
//  Similar
//
//  Created by Denis Shkultetskyy on 23.04.2025.
//
import Photos
import UIKit

final class PhotoViewModel {
    
    let asset: PHAsset
    var isChecked: Bool = false {
        didSet {
            check()
            signalToCheck?(isChecked)
        }
    }
    
    private var check: EmptyAction
    
    private var signalToCheck: ((Bool) ->())?
    private var _previewImag: UIImage?
    var image: UIImage {
        get async {
            if let _previewImag { return _previewImag }
            
            _previewImag = await asset.previewImage
            return _previewImag ?? UIImage.imageLoadFailed
        }
    }
    var detailsImage: UIImage {
        get async {
            await asset.detailsImage ?? UIImage.imageLoadFailed
        }
    }
    
    
    internal init(asset: PHAsset , _ action: @escaping EmptyAction) {
        self.asset = asset
        self.check = action
    }
    
    func onChecked(_ action: @escaping (Bool) ->()) {
        signalToCheck = action
    }
    
    private static let options: PHImageRequestOptions = {
        let options = PHImageRequestOptions()
        options.resizeMode = .fast
        options.isNetworkAccessAllowed = false
        options.deliveryMode = PHImageRequestOptionsDeliveryMode.highQualityFormat
        options.isSynchronous = true
        
        return options
    }()
}

