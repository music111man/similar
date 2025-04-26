//
//  FilePhotoService.swift
//  Similar
//
//  Created by Denis Shkultetskyy on 26.04.2025.
//

import UIKit
import Photos

final class FilePhotoService {
    
    func checkAccess() async -> Bool {
        return await PHPhotoLibrary.requestAuthorization(for: .readWrite) == .authorized
    }
    
}
