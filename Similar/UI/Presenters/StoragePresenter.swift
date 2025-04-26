//
//  StorePresenter.swift
//  Similar
//
//  Created by Denis Shkultetskyy on 23.04.2025.
//

import UIKit

protocol StoragePresenterDelegate: AnyObject {
    var checkedCountMessage: String? { set get }
    var topCountMessage: String { set get }
    var table: UITableView { get }
    
}

@MainActor
final class StoragePresenter: NSObject {
    private var photoCount = 0
    var storage: SimilarStorage? {
        didSet {
            defer { delegate?.table.reloadData() }
            guard let storage else {
                delegate?.table.showActivity = true
                self.formatCheckedCountMessage(nil)
                return
            }
            storage.onCheck({ count in
                self.formatCheckedCountMessage(count)
            })
            photoCount = storage.similarCollection.flatMap { $0.photos }.count
            self.formatCheckedCountMessage(0)
            delegate?.table.showActivity = false
            delegate?.table.reloadData()
        }
    }
    
    weak var delegate: StoragePresenterDelegate? {
        didSet {
            delegate?.table.dataSource = self
            delegate?.table.register(SimilarCell.self, forCellReuseIdentifier: SimilarCell.identifier)
        }
    }
    
    var openPhotoAction: ((UIImage) -> ())?
    
    
    func openImage(_ action: @escaping (UIImage) -> ()) {
        self.openPhotoAction = action

    }
    
    private func formatCheckedCountMessage(_ count: Int?) {
        guard let count else {
            self.delegate?.topCountMessage = LocalizableText.searchSilimars.description
            self.delegate?.checkedCountMessage = nil
            return
        }
        self.delegate?.topCountMessage = LocalizableText.subTitlePhotos.with(value: photoCount) + " • " + LocalizableText.subTitlePhotos.with(value: count)
        self.delegate?.checkedCountMessage = count == 0 ? nil : LocalizableText.deleteSimilars.with(value: count)
    }
    
    @MainActor
    func showDeleteProcess() async {
        self.delegate?.table.showActivity = true
        self.delegate?.checkedCountMessage = nil
        self.delegate?.topCountMessage = LocalizableText.deleteSimmilars.description
        
        self.delegate?.table.isUserInteractionEnabled = false
    }

    func showCongratulation() {
        self.delegate?.table.showActivity = false
        self.delegate?.table.isUserInteractionEnabled = true
    }
    
}

extension StoragePresenter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        storage?.similarCollection.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SimilarCell.identifier, for: indexPath) as! SimilarCell
        if let storage {
            
            cell.configure(storage.similarCollection[indexPath.row])
            cell.presenter.onTapImage { image in
                self.openPhotoAction?(image)
            }
        }
        
        return cell
    }
    
    
}

