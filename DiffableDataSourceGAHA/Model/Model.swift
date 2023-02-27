//
//  Model.swift
//  DiffableDataSourceGAHA
//
//  Created by Aleksandr Eliseev on 24.02.2023.
//

import UIKit

struct Number: Decodable {
    let number: Int
}

struct APIResponse: Decodable {
    let numbers: [Number]
}

struct CellModel: Hashable {
    let number: Int
    let height: CGFloat
    let color: UIColor
}
