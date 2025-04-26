//
//  SimilarManager.swift
//  Similar
//
//  Created by Denis Shkultetskyy on 23.04.2025.
//

import Foundation

protocol SimilarManagerProtocol: AnyObject {
    func searchSimilar() async
    func deteteSimilar() async
}

@MainActor
class SimilarManagerFactory {
    private init() {}
    static func createManager(presenterDelegate: StoragePresenterDelegate, routerDelegate: RouterDelegate) -> some SimilarManagerProtocol {
        let manager = SimilarManager()
        manager.presenter = StoragePresenter()
        manager.presenter.delegate = presenterDelegate
        manager.router = Router()
        manager.router.delegate = routerDelegate
        
        
        return manager
    }
}

final class SimilarManager: SimilarManagerProtocol {
    @MainActor
    static func createManager(presenterDelegate: StoragePresenterDelegate, routerDelegate: RouterDelegate) -> some SimilarManagerProtocol {
        let manager = SimilarManager()
        manager.presenter = StoragePresenter()
        manager.presenter.delegate = presenterDelegate
        manager.router = Router()
        manager.router.delegate = routerDelegate
        
        
        return manager
    }
    @MainActor
    var presenter: StoragePresenter! {
        didSet {
            presenter.openImage { image in
                self.router.showImage(image)
            }
        }
    }
    var router: Router!
    
    let fileService = FilePhotoService()
    
    fileprivate init() { }
    
    
    @MainActor
    func searchSimilar() async {
        
        presenter.storage = nil
        await requireAccessToGalery()
        try? await Task.sleep(nanoseconds: 3_000_000_000)
        presenter.storage = SimilarStorage()
    }
    
    func deteteSimilar() async {
        guard await router.ackToDelete() else { return }
        await presenter.showDeleteProcess()
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        await presenter.showCongratulation()
        await router.showCongratulation(deletedCount: presenter.storage?.checkedCount ?? 0)
        await searchSimilar()
        
        return
    }
    
    private func requireAccessToGalery() async {
        if await fileService.checkAccess() { return }
        await router.settingsPromt()
        try? await Task.sleep(nanoseconds: 2_000_000)
        await requireAccessToGalery()
    }
}
