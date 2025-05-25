//
//  AccountsMocks.swift
//  Money-manager
//
//  Created by Oleksii Karas on 24.05.2025.
//

import Foundation

enum Mocks: String, MockLoadable {
    case accounts = "AccountsMock"

    var mock: Data {
        loadJSON(fileNamed: self.rawValue)
    }
}
