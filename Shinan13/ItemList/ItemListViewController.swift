//
//  ItemListViewController.swift
//  Shinan13
//
//  Created by Turara on 2020/08/08.
//  Copyright © 2020 Turara. All rights reserved.
//

import SnapKit
import UIKit

final class ItemListViewController: UIViewController {
    
    var presenter: ItemListPresenterInput!
    
    private var selectingIndexPath: IndexPath?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(ItemCell.self, forCellReuseIdentifier: ItemCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        tableView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide.snp.edges)
        }
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "アイテム一覧"
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .add, target: self, action: #selector(didPushAddButton(_:)))
        // tableViewの初期化
        _ = tableView
        
        presenter.viewDidLoad()
    }
}

extension ItemListViewController: ItemListPresenterOutput {
    func reloadItems() {
        tableView.reloadData()
    }
    
    func reloadItem(ofID id: Int) {
        if let selectingIndexPath = selectingIndexPath {
            tableView.reloadRows(at: [selectingIndexPath], with: .automatic)
        } else {
            tableView.reloadData()
        }
        selectingIndexPath = nil
    }
}

extension ItemListViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        if let navigationController = presentationController.presentedViewController as? UINavigationController {
            switch navigationController.topViewController {
            case is ItemEditViewController:
                presenter.didDismissItemEdit()
            default:
                break
            }
        }
    }
}

extension ItemListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemCell.identifier, for: indexPath)
        
        if let itemCell = cell as? ItemCell {
            let item = presenter.items[indexPath.row]
            itemCell.checkImageView.isHidden = !item.isChecked
            itemCell.textLabel?.text = item.name
        }
        
        return cell
    }
}

extension ItemListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectingIndexPath = indexPath
        let item = presenter.items[indexPath.row]
        presenter.didSelectItem(ofID: item.id)
    }
}

extension ItemListViewController {
    @objc private func didPushAddButton(_ sender: UINavigationItem) {
        presenter.didPushAddButton()
    }
}
