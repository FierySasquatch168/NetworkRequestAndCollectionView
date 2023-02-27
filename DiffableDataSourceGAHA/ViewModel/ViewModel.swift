//
//  ViewModel.swift
//  DiffableDataSourceGAHA
//
//  Created by Aleksandr Eliseev on 27.02.2023.
//

import Foundation

protocol ViewModelDelegate: AnyObject {
    func didRFormedModel(model: [CellModel])
}

class ViewModel {
    private let dataConverter = DataConverter.shared
    var viewModelDelegate: ViewModelDelegate
    
    init(viewModelDelegate: ViewModelDelegate) {
        self.viewModelDelegate = viewModelDelegate
    }
    
    func createViewModel(from response: APIResponse) {
        let numbersToFill = dataConverter.convert(from: response)
        let indexesToPaint = dataConverter.findTheKeyIndexesToColor(from: numbersToFill)
        
        var cellDataBaseModel: [CellModel] = []
        for i in 0..<numbersToFill.count {
            if indexesToPaint.contains(i) {
                let cellModel = CellModel(number: numbersToFill[i], height: 100, color: .red)
                cellDataBaseModel.append(cellModel)
            } else {
                let cellModel = CellModel(number: numbersToFill[i], height: 50, color: .orange)
                cellDataBaseModel.append(cellModel)
            }
        }
        
        viewModelDelegate.didRFormedModel(model: cellDataBaseModel)
    }
    
}
