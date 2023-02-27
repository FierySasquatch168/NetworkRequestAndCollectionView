//
//  NumbersLoader.swift
//  DiffableDataSourceGAHA
//
//  Created by Aleksandr Eliseev on 24.02.2023.
//

import Foundation

protocol NumbersLoading {
    func loadData(from urlString: String) async throws -> APIResponse
}

struct NumbersLoader: NumbersLoading {

    func loadData(from urlString: String) async throws -> APIResponse {
        guard let url = URL(string: urlString) else {
            throw FetchError.invalidURL
        }
        let session = URLSession.shared
        let (data, _) = try await session.data(from: url)
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(APIResponse.self, from: data)
        } catch {
            throw FetchError.invalidData
        }
        
    }
}
