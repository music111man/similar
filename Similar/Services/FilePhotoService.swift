//
//  FilePhotoService.swift
//  Similar
//
//  Created by Denis Shkultetskyy on 26.04.2025.
//

import UIKit
import Photos

protocol FilePhotoServiceProtocol: AnyObject {
    func checkAccess() async -> Bool
    func load() async -> Set<PHAsset>
    func delete(_ assets: [PHAsset]) async -> Int
}

enum FilePhotoServiceFactory {
    static func create() -> some FilePhotoServiceProtocol {
        FilePhotoService()
    }
}

final class FilePhotoService: FilePhotoServiceProtocol {
    
    fileprivate init() {}
    
    func checkAccess() async -> Bool {
        return await PHPhotoLibrary.requestAuthorization(for: .readWrite) == .authorized
    }
    
    func load() async -> Set<PHAsset>  {
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        options.includeAllBurstAssets = false
        options.includeHiddenAssets = false
        options.includeAssetSourceTypes = .typeUserLibrary

        let result = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: options)
        
        var assets = Set<PHAsset>();
        result.enumerateObjects { asset, _, _ in
            assets.insert(asset)
        }
        
        return assets

    }
         
    func delete(_ assets: [PHAsset]) async -> Int {
        await withCheckedContinuation { continuation in
            let deleteCount = assets.count
            PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.deleteAssets(assets as NSFastEnumeration)
                
            }) { success, error in
                if let error {
                    print("Failed to delete photos: \(error)")
                }
                continuation.resume(returning: success ? deleteCount : 0)
            }
        }
        
    }
    
                                     
}
