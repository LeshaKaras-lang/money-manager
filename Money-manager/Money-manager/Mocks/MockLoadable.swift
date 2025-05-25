//
//  MockLoadable.swift
//  Money-manager
//
//  Created by Oleksii Karas on 24.05.2025.
//

import Foundation

protocol MockLoadable {
    var mock: Data { get }
    
    func loadJSON(fileNamed: String) -> Data
}

extension MockLoadable {
    func loadJSON(fileNamed: String) -> Data {
        guard let url = Bundle.main.url(forResource: fileNamed, withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            fatalError("Mock not found")
        }
        return data
    }
}
