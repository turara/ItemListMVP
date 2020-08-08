//
//  ItemCell.swift
//  Shinan13
//
//  Created by Turara on 2020/08/08.
//  Copyright © 2020 Turara. All rights reserved.
//

import Foundation
import UIKit

class ItemCell: UITableViewCell {
    static var identifier: String = "ItemCell"

    lazy var checkImageView: UIImageView = {
        let image = UIImage(named: "check-mark")
        let imageView = UIImageView(image: image)
        contentView.addSubview(imageView)
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        checkImageView.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 24, height: 24))
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(8)
        }
        textLabel?.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.top.equalToSuperview().offset(12)
            $0.bottom.equalToSuperview().offset(-12)
            $0.left.equalTo(self.checkImageView.snp.right).offset(8)
            $0.right.equalToSuperview().offset(-8)
        }
    }
}
