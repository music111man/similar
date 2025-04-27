//
//  PHAsset.swift
//  Similar
//
//  Created by Denis Shkultetskyy on 27.04.2025.
//

import Photos
import UIKit

fileprivate let previewOptions: PHImageRequestOptions = {
    let options = PHImageRequestOptions()
    options.resizeMode = .fast
    options.isNetworkAccessAllowed = false
    options.deliveryMode = PHImageRequestOptionsDeliveryMode.highQualityFormat
    options.isSynchronous = false
    
    return options
}()

fileprivate let detailsOptions: PHImageRequestOptions = {
    let options = PHImageRequestOptions()
    options.resizeMode = .none
    options.isNetworkAccessAllowed = false
    options.deliveryMode = PHImageRequestOptionsDeliveryMode.highQualityFormat
    options.isSynchronous = false
    
    return options
}()

extension PHAsset {
    @MainActor
    var previewImage: UIImage? {
        get async {
            return await withCheckedContinuation { continuation in
                PHImageManager.default().requestImage(for: self,
                                                      targetSize: CGSize(width: 183.width, height: 215.height),
                                                      contentMode: PHImageContentMode.aspectFill,
                                                      options: previewOptions) { image, _ in
                    continuation.resume(returning: image)
                }
            }
        }
    }
    
    var detailsImage: UIImage? {
        get async {
            return await withCheckedContinuation { continuation in
                PHImageManager.default().requestImage(for: self,
                                                      targetSize: screenBounds.size,
                                                      contentMode: PHImageContentMode.aspectFit,
                                                      options: detailsOptions) { image, _ in
                    continuation.resume(returning: image)
                }
            }

        }
    }
   
    var imageUrl: URL? {
        get async {
            return await withCheckedContinuation { continuation in
                let options = PHContentEditingInputRequestOptions()
                options.canHandleAdjustmentData = {(adjustmeta: PHAdjustmentData) -> Bool in
                    return true
                }
                self.requestContentEditingInput(with: options, completionHandler: { (contentEditingInput, info) in
                    if let fullSizeImageUrl = contentEditingInput?.fullSizeImageURL {
                        continuation.resume(returning: fullSizeImageUrl)
                    } else {
                        continuation.resume(returning:nil)
                    }
                })
            }
        }
    }
    
    var videoUrl: URL? {
        get async {
            return await withCheckedContinuation { continuation in
                let options: PHVideoRequestOptions = PHVideoRequestOptions()
                options.version = .original
                PHImageManager.default().requestAVAsset(forVideo: self, options: options, resultHandler: { (asset, audioMix, info) in
                    if let urlAsset = asset as? AVURLAsset {
                        let localVideoUrl = urlAsset.url
                        continuation.resume(returning: localVideoUrl)
                    } else {
                        continuation.resume(returning:nil)
                    }
                })
            }
        }
    }
    
    var ciImage: CIImage? {
        get async {
            guard let url = await self.imageUrl,
                  let image = CIImage(contentsOf: url) else { return nil }
            
            return image
        }
    }
}
