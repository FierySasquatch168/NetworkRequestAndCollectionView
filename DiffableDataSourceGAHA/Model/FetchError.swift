//
//  FetchError.swift
//  DiffableDataSourceGAHA
//
//  Created by Aleksandr Eliseev on 24.02.2023.
//

import Foundation

enum FetchError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case unableToComplete
}
