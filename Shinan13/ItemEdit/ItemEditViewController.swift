//
//  ItemEditViewController.swift
//  Shinan13
//
//  Created by Turara on 2020/08/08.
//  Copyright © 2020 Turara. All rights reserved.
//

import SnapKit
import UIKit

final class ItemEditViewController: UIViewController, ItemEditPresenterOutput {
    
    var presenter: ItemEditPresenterInput!
    var mode: Mode!
    
    private lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "名前"
        label.font = .systemFont(ofSize: 20)
        view.addSubview(label)
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.font = .systemFont(ofSize: 24)
        textField.text = presenter.initialName
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray5.cgColor
        view.addSubview(textField)
        textField.addTarget(
            self,
            action: #selector(didTextFieldEditingChange(_:)),
            for: .editingChanged
        )
        didTextFieldEditingChange(textField)
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = mode.title
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.leftBarButtonItem = .init(
            title: "キャンセル",
            style: .plain,
            target: self,
            action: #selector(didPushCancelButton(_:))
        )
        navigationItem.rightBarButtonItem = .init(
            title: "保存",
            style: .done,
            target: self,
            action: #selector(didPushSaveButton(_:))
        )
        setupViews()
    }
    
    private func setupViews() {
        let stackView = UIStackView(arrangedSubviews: [label, textField])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 8
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.left.equalToSuperview().offset(48)
            $0.right.equalToSuperview().offset(-48)
        }
        label.snp.makeConstraints { $0.width.lessThanOrEqualTo(40) }
    }

}

extension ItemEditViewController {
    @objc func didPushCancelButton(_ sender: UIBarButtonItem) {
        presenter.didPushCancelButton()
    }
    
    @objc func didPushSaveButton(_ sender: UIBarButtonItem) {
        if let name = textField.text  {
            presenter.didPushSaveButton(with: name)
        }
    }
    
    @objc func didTextFieldEditingChange(_ sender: UITextField) {
        navigationItem.rightBarButtonItem?.isEnabled = sender.text?.isEmpty == false
    }
}

extension ItemEditViewController {
    enum Mode {
        case create
        case edit
        
        var title: String {
            switch self {
            case .create:
                return "新規追加"
            case .edit:
                return "編集"
            }
        }
    }
}

