//
//  ItemListPresenter.swift
//  Shinan13
//
//  Created by Turara on 2020/08/09.
//  Copyright © 2020 Turara. All rights reserved.
//

import Foundation

protocol ItemListPresenterInput {
    var items: [Item] { get }
    func fetchItems()
    func didPushAddButton()
    func didSelectItem(ofID id: Int)
    func didDismissItemEdit()
}

protocol ItemListPresenterOutput: AnyObject {
    func reloadItems()
    func reloadItem(ofID id: Int)
}

final class ItemListPresenter: ItemListPresenterInput {
    weak var router: Router!
    var repository: ItemRepositoryProtocol!
    weak var view: ItemListPresenterOutput!
    
    var items: [Item] = []
    
    func fetchItems() {
        items = repository.fetchItems()
    }
    
    func didPushAddButton() {
        router.showItemEditView(editID: nil)
    }
    
    func didSelectItem(ofID id: Int) {
        repository.toggleIsChecked(ofItemID: id)
        fetchItems()
        view.reloadItem(ofID: id)
    }
    
    func didDismissItemEdit() {
        fetchItems()
        view.reloadItems()
    }
}
