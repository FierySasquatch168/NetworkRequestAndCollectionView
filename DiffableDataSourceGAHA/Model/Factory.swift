//
//  Factory.swift
//  DiffableDataSourceGAHA
//
//  Created by Aleksandr Eliseev on 24.02.2023.
//

import UIKit

final class Factory {
    
    private let constants = Constants.shared
    private let urlQuery = "cKT8eYt5"
    private var viewModelDelegate: ViewModelDelegate
    private var numbersLoader: NumbersLoading
    
    init(viewModelDelegate: ViewModelDelegate, numbersLoader: NumbersLoading) {
        self.viewModelDelegate = viewModelDelegate
        self.numbersLoader = numbersLoader
    }
    
    func loadNumbers() {
        let stringURL = constants.baseUrl + urlQuery
        Task {
            do {
                let response = try await numbersLoader.loadData(from: stringURL)
                let viewModel = ViewModel(viewModelDelegate: viewModelDelegate)
                viewModel.createViewModel(from: response)
            } catch {
                throw FetchError.invalidResponse
            }
        }
    }
}
