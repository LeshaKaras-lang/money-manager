//
//  ChartReducer.swift
//  Money-manager
//
//  Created by Oleksii Karas on 24.05.2025.
//

import Foundation
import ComposableArchitecture

struct ChartReducer: Reducer {
    
    enum Period: String, CaseIterable, Equatable {
        case week = "Week"
        case month = "Month"
        case year = "Year"
    }

    struct State: Equatable {
        var transactions: [Transaction] = []
        var selectedPeriod: Period = .week
        var selectedDate: Date?
        var error: String?
    }

    enum Action: Equatable {
        case onAppear
        case periodChanged(Period)
        case daySelected(Date)
        case dataLoaded([Transaction])
        case failedToLoad(String)
    }

    @Dependency(\.accountService) var accountService

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .run { send in
                    do {
                        let transactions = try await accountService.transaction()
                        await send(.dataLoaded(transactions))
                    } catch {
                        await send(.failedToLoad(error.localizedDescription))
                    }
                }
            case let .dataLoaded(data):
                state.transactions = data
                state.selectedDate = data.last?.date
                return .none
                
            case .periodChanged(let period):
                state.selectedPeriod = period
                return .none
                
            case .daySelected(let date):
                state.selectedDate = date
                return .none
            case let .failedToLoad(error):
                state.error = error
                return .none
            }
        }
    }
}
