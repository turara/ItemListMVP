//
//  ItemEditPresenter.swift
//  Shinan13
//
//  Created by Turara on 2020/08/09.
//  Copyright © 2020 Turara. All rights reserved.
//

import Foundation

protocol ItemEditPresenterInput {
    var initialName: String { get }
    func didPushCancelButton()
    func didPushSaveButton(with name: String)
}

protocol ItemEditPresenterOutput: AnyObject {}

final class ItemEditPresenter: ItemEditPresenterInput {
    var initialName: String = ""
    
    weak var router: Router!
    var repository: ItemRepositoryProtocol!
    weak var view: ItemEditPresenterOutput!
    
    func didPushCancelButton() {
        router.dismissItemEditView()
    }
    
    func didPushSaveButton(with name: String) {
        repository.addItem(name: name, isChecked: false)
        router.dismissItemEditView()
    }
}
