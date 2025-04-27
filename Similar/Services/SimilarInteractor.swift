//
//  SimilarManager.swift
//  Similar
//
//  Created by Denis Shkultetskyy on 23.04.2025.
//

import Foundation

protocol SimilarInteractorProtocol: AnyObject {
    func setSimilar(value: Double)
    func searchSimilar() async
    func deteteSimilar() async
}

@MainActor
class SimilarInteractorFactory {
    private init() {}
    static func create(presenterDelegate: StoragePresenterDelegate, routerDelegate: RouterDelegate) -> some SimilarInteractorProtocol {
        let manager = SimilarInteractor(router: RouterFactory.create(routerDelegate),
                                     presenter: StoragePresenterFactory.create(presenterDelegate), fileService: FilePhotoServiceFactory.create(),
                                     similarService: SimilarImageServiceFactory.create())
        
        return manager
    }
}

final class SimilarInteractor: SimilarInteractorProtocol {

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
        self.similarService.observeSearchStatus { remainsToProcessCount in
            Task {
                await self.presenter.showSearchProcess(remainsToProcessCount)
            }
        }
        setSimilar(value: UserDefaults.degreeOfSimilarity)
    }
    
    func setSimilar(value: Double) {
        similarService.degreeOfSimilarity = Float((100 - value) * 0.01)
        print(similarService.degreeOfSimilarity)
        UserDefaults.degreeOfSimilarity = value
        presenter.setSimilar(value: value)
    }
    
    @MainActor
    func searchSimilar() async {
        
        presenter.storage = nil
        await requireAccessToGalery()
        var assets = await fileService.load()
        presenter.storage = SimilarStorage(await similarService.searchSimilars(&assets))
    }
    
    func deteteSimilar() async {
        guard let assets = presenter.storage?.checketAssets, !assets.isEmpty  else { return }
        
        await presenter.visibleDeleteProcess()
        let deleteCount = await fileService.delete(assets)
        if deleteCount == 0 {
            await presenter.undoDeleteProcess()
            return
        }

        await router.showCongratulation(deletedCount: deleteCount)
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
