//
//  ItemRepository.swift
//  Shinan13
//
//  Created by Turara on 2020/08/08.
//  Copyright © 2020 Turara. All rights reserved.
//

import Foundation

protocol ItemRepositoryProtocol {
    func fetchItems() -> [Item]
    func addItem(name: String, isChecked: Bool)
    func toggleIsChecked(ofItemID id: Int)
}

class ItemRepository: ItemRepositoryProtocol {
    
    private var items: [Item] = [
        Item(id: 1, name: "りんご", isChecked: false),
        Item(id: 2, name: "みかん", isChecked: true),
        Item(id: 3, name: "バナナ", isChecked: false),
        Item(id: 4, name: "パイナップル", isChecked: true),
    ]
    
    func fetchItems() -> [Item] {
        items
    }
    
    func addItem(name: String, isChecked: Bool) {
        let id = (items.max(by: { $0.id < $1.id })?.id ?? 0) + 1
        items.append(Item(id: id, name: name, isChecked: isChecked))
    }
    
    func toggleIsChecked(ofItemID id: Int) {
        for (i, item) in items.enumerated() {
            if item.id == id {
                let newItem = Item(id: item.id, name: item.name, isChecked: !item.isChecked)
                items[i] = newItem
            }
        }
    }
}
