//
//  SimilarManager.swift
//  Similar
//
//  Created by Denis Shkultetskyy on 23.04.2025.
//

import Foundation

protocol MainInteractorProtocol: AnyObject {
    func searchSimilar() async
    func deteteSimilar() async
}

@MainActor
class SimilarManagerFactory {
    private init() {}
    static func createManager(presenterDelegate: StoragePresenterDelegate, routerDelegate: RouterDelegate) -> some MainInteractorProtocol {
        let manager = MainInteractor(router: RouterFactory.create(routerDelegate),
                                     presenter: StoragePresenterFactory.create(presenterDelegate), fileService: FilePhotoServiceFactory.create(),
                                     similarService: SimilarImageServiceFactory.create())
        
        return manager
    }
}

final class MainInteractor: MainInteractorProtocol {

    let presenter: StoragePresenterProtocol
    let  router: RouterProtocol
    let fileService: FilePhotoServiceProtocol!
    let similarService: SimilarImageServiceProtocol!
    
    @MainActor
    fileprivate init(router: some RouterProtocol,
                     presenter: some StoragePresenterProtocol,
                     fileService: some FilePhotoServiceProtocol,
                     similarService: some SimilarImageServiceProtocol) {
        self.router = router
        self.presenter = presenter
        self.fileService = fileService
        self.similarService = similarService
        
        self.presenter.openImage { asset in
            Task {
                await self.router.showImage(asset)
            }
        }
    }
    
    
    @MainActor
    func searchSimilar() async {
        
        presenter.storage = nil
        await requireAccessToGalery()
        var assets = await fileService.load()
        presenter.storage = SimilarStorage(await similarService.searchSimilars(&assets))
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
