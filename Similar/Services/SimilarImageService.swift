//
//  SimilarImageService.swift
//  Similar
//
//  Created by Denis Shkultetskyy on 25.04.2025.
//

import UIKit
import Photos
import Vision

protocol SimilarImageServiceProtocol: AnyObject {
    var degreeOfSimilarity: Float { get set }
    func searchSimilars(_ assets: inout Set<PHAsset>) async -> Set<[PHAsset]>
    func observeSearchStatus(_ action: @escaping(Int) ->() )
}
enum SimilarImageServiceFactory {
    static func create() -> some SimilarImageServiceProtocol {
        SimilarImageService()
    }
}

final class SimilarImageService: SimilarImageServiceProtocol {
    
    
    
    fileprivate init() {}
    
    var degreeOfSimilarity: Float = 0.4
    
    private var action: ((Int) -> ())?
    
    func observeSearchStatus(_ action: @escaping (Int) -> ()) {
        self.action = action
    }
    
    func searchSimilars(_ assets: inout Set<PHAsset>) async -> Set<[PHAsset]> {
        var resultSet = Set<[PHAsset]>()
        var allCount = assets.count
        print("Start count \(assets.count)")
        while !assets.isEmpty {
            guard let originalAsset = assets.popFirst(),
                  let originalDate = originalAsset.creationDate?.withOutTime,
                  let originalFeaturePrint = await originalAsset.previewImage?.featurePrint else { continue }
            var photoAssets = [originalAsset]
            
            for asset in assets where asset.creationDate?.withOutTime == originalDate {
                
                var distance: Float = .infinity
                guard let featurePrint = await asset.previewImage?.featurePrint,
                      let _ = try? originalFeaturePrint.computeDistance(&distance, to: featurePrint),
                      degreeOfSimilarity >= distance else {
                    if allCount > assets.count {
                        allCount = assets.count
                        self.action?(allCount)
                    }
                    continue
                }
                
                photoAssets.append(asset)
            }
            
            if photoAssets.count > 1 {
                for asset in photoAssets {
                    assets.remove(asset)
                }
                resultSet.insert(photoAssets)
            }
            allCount = assets.count
            self.action?(allCount)
        }
        
        return resultSet
    }
    
}

extension UIImage {
    
    var featurePrint: VNFeaturePrintObservation? {
        guard  let cgImage = self.cgImage else { return  nil }
        let request =  VNGenerateImageFeaturePrintRequest ()
        let requestHandler =  VNImageRequestHandler (cgImage: cgImage,
                                                     orientation: .init(self.imageOrientation))
        do {
            try requestHandler.perform([request])
        } catch {
            print ( "featurePrint: \(error) " )
        }
        
        return request.results?.first
    }
    
    
}

extension CGImagePropertyOrientation {
    init(_ uiOrientation: UIImage.Orientation) {
        switch uiOrientation {
            case .up: self = .up
            case .upMirrored: self = .upMirrored
            case .down: self = .down
            case .downMirrored: self = .downMirrored
            case .left: self = .left
            case .leftMirrored: self = .leftMirrored
            case .right: self = .right
            case .rightMirrored: self = .rightMirrored
            @unknown default:
                fatalError()
        }
    }
}
