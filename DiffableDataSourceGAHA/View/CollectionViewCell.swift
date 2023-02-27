//
//  CollectionViewCell.swift
//  DiffableDataSourceGAHA
//
//  Created by Aleksandr Eliseev on 24.02.2023.
//

import UIKit

final class CollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "CollectionViewCell"
    
    private lazy var numberButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        return button
    }()
    
    func setupCell(with item: CellModel) {
        let numberTitle = String(item.number)
        numberButton.setTitle(numberTitle, for: .normal)
        numberButton.backgroundColor = item.color
        
        contentView.addSubview(numberButton)
        numberButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            numberButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            numberButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            numberButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            numberButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            numberButton.heightAnchor.constraint(equalToConstant: item.height)
        ])
    }
    
}
