//
//  RouterViewController.swift
//  Shinan13
//
//  Created by Turara on 2020/08/08.
//  Copyright © 2020 Turara. All rights reserved.
//

import UIKit

protocol Router: AnyObject {
    func showItemEditView(editID: Int?)
    func dismissItemEditView()
}


final class RouterViewController: UIViewController {
    
    private var itemNavigationController: UINavigationController!
    private var itemRepository = ItemRepository()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentItemListView()
    }
}

extension RouterViewController: Router {
    fileprivate func presentItemListView() {
        let itemListPresenter = ItemListPresenter()
        let itemListVC = ItemListViewController()
        
        itemListPresenter.router = self
        itemListPresenter.repository = itemRepository
        itemListPresenter.view = itemListVC
        
        itemListVC.presenter = itemListPresenter
        
        itemNavigationController = UINavigationController(rootViewController: itemListVC)
        itemNavigationController.modalPresentationStyle = .fullScreen
        present(itemNavigationController!, animated: false, completion: nil)
    }
    
    func showItemEditView(editID: Int?) {
        if let itemListVC = itemNavigationController.topViewController as? ItemListViewController {

            let itemEditPresenter = ItemEditPresenter()
            let itemEditVC = ItemEditViewController()
            
            itemEditPresenter.router = self
            itemEditPresenter.repository = itemRepository
            itemEditPresenter.view = itemEditVC
            
            itemEditVC.presenter = itemEditPresenter
            itemEditVC.mode = editID == nil ? .create : .edit
            
            let itemEditNC = ItemEditNavigationController(rootViewController: itemEditVC)
            itemEditNC.onDismiss = {
                itemListVC.presenter.fetchItems()
                itemListVC.reloadItems()
            }
            itemListVC.present(itemEditNC, animated: true, completion: nil)
        }
    }
    
    func dismissItemEditView() {
        if let topVC = itemNavigationController.topViewController?.presentedViewController {
            topVC.dismiss(animated: true, completion: nil)
        }
    }
    
}

