//
//  SimilarImageService.swift
//  Similar
//
//  Created by Denis Shkultetskyy on 25.04.2025.
//

import Foundation
import Photos
import Vision

protocol SimilarImageServiceProtocol: AnyObject {
    func searchSimilars(_ assets: inout Set<PHAsset>) async -> Set<[PHAsset]>
}
enum SimilarImageServiceFactory {
    static func create() -> some SimilarImageServiceProtocol {
        SimilarImageService()
    }
}

final class SimilarImageService: SimilarImageServiceProtocol {

    fileprivate init() {}
    
    func searchSimilars(_ assets: inout Set<PHAsset>) async -> Set<[PHAsset]> {
        var resultSet = Set<[PHAsset]>()
        while !assets.isEmpty {
            var photoAssets = [PHAsset]()
            for _ in (0...Int.random(in: 1...6)) {
                guard let asset = assets.popFirst() else { break }
                
                photoAssets.append(asset)
            }
            resultSet.insert(photoAssets)
        }
        
        return resultSet
    }
    
}
