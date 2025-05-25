//
//  AccountService.swift
//  Money-manager
//
//  Created by Oleksii Karas on 24.05.2025.
//

import Foundation
import ComposableArchitecture

protocol AccountService: Sendable {
    func transaction() async throws -> [Transaction]
}

actor MockAccountService: AccountService, Sendable {
    
    private var transactionsCache: [Transaction]?
    
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        decoder.dateDecodingStrategy = .formatted(formatter)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    func transaction() async throws -> [Transaction] {
        if let cache = transactionsCache {
            return cache
        }
        let data = Mocks.accounts.mock
        let result = try decoder.decode([Transaction].self, from: data)
        transactionsCache = result
        return result
    }
}

private enum AccountServiceKey: DependencyKey {
    static let liveValue: AccountService = MockAccountService()
    static let previewValue: AccountService = MockAccountService()
    static let testValue: AccountService = MockAccountService()
}

extension DependencyValues {
    var accountService: AccountService {
        get { self[AccountServiceKey.self] }
        set { self[AccountServiceKey.self] = newValue }
    }
}
