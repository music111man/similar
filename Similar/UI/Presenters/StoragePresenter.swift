//
//  StorePresenter.swift
//  Similar
//
//  Created by Denis Shkultetskyy on 23.04.2025.
//

import UIKit

protocol StoragePresenterDelegate: AnyObject {
    var checkedCount: Int { set get }
    var table: UITableView { get }
    func showImage(_ image: UIImage)
}

@MainActor
final class StoragePresenter: NSObject {
    
    var storage: SimilarStorage? {
        didSet {
            
            storage?.onCheck({ count in
                self.delegate?.checkedCount = count
            })
            delegate?.table.reloadData()
        }
    }
    
    weak var delegate: StoragePresenterDelegate? {
        didSet {
            delegate?.table.dataSource = self
            delegate?.table.register(SimilarCell.self, forCellReuseIdentifier: SimilarCell.identifier)
        }
    }
    
    override init() {
        super.init()
        
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
                self.delegate?.showImage(image)
            }
        }
        
        return cell
    }
    
    
}

