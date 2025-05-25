//
//  TransactionListReducer.swift
//  Money-manager
//
//  Created by Oleksii Karas on 24.05.2025.
//

import Foundation
import ComposableArchitecture

struct TransactionListReducer: Reducer {
    
    // MARK: - State

    struct State: Equatable {
        var transactions: [Transaction] = []
        var isLoading = false
        var error: String?
    }
    
    // MARK: - Action
    
    enum Action: Equatable {
        case onAppear
        case loadTransactions
        case transactionsLoaded([Transaction])
        case failedToLoad(String)
    }
    
    // MARK: - Dependencies
    
    @Dependency(\.accountService) var accountService
    
    // MARK: - Reducer
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
            
        case .onAppear:
            return .send(.loadTransactions)
            
        case .loadTransactions:
            state.isLoading = true
            state.error = nil
            return .run { send in
                do {
                    let transactions = try await accountService.transaction()
                    await send(.transactionsLoaded(transactions))
                } catch {
                    await send(.failedToLoad(error.localizedDescription))
                }
            }
            
        case let .transactionsLoaded(transactions):
            state.isLoading = false
            state.transactions = transactions
            return .none
            
        case let .failedToLoad(error):
            state.isLoading = false
            state.error = error
            return .none
        }
    }
}
