//
//  DataConverter.swift
//  DiffableDataSourceGAHA
//
//  Created by Aleksandr Eliseev on 27.02.2023.
//

import Foundation

final class DataConverter {
    static let shared = DataConverter()
    
    func convert(from model: APIResponse) -> [Int] {
        var numbers: [Int] = []
        for i in 0..<model.numbers.count {
            let number = model.numbers[i]
            numbers.append(number.number)
        }
        return numbers
    }
    
    func findTheKeyIndexesToColor(from array: [Int]) -> [Int] {
        let positiveSorted = array.map { $0 < 0 ? (-1 * $0) : $0 }.sorted(by: >) // make all >= 0 and sort for getting duplicates together
        
        var itemsToColor: [Int] = []
        for i in 0..<positiveSorted.count-1 {
            let num1 = positiveSorted[i]
            let num2 = positiveSorted[i + 1]
            if num1 == num2 {
                itemsToColor.append(num1) // append duplicates for further search
            }
        }
        
        var indexesToColor: [Int] = []
        for keyIndex in 0..<itemsToColor.count {
            for (index, value) in array.enumerated() {
                if value == itemsToColor[keyIndex] || value == (-1 * itemsToColor[keyIndex]) {
                    indexesToColor.append(index) // find indexes, where red should be applied
                }
            }
        }
        return indexesToColor
    }
}
