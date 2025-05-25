//
//  AppReducer.swift
//  Money-manager
//
//  Created by Oleksii Karas on 24.05.2025.
//

import ComposableArchitecture
import CasePaths

struct AppReducer: Reducer {

    struct State: Equatable {
        var chart = ChartReducer.State()
        var accountList = TransactionListReducer.State()
    }

    @CasePathable
    enum Action: Equatable {
        case chart(ChartReducer.Action)
        case accountList(TransactionListReducer.Action)
    }

    var body: some ReducerOf<Self> {
        Scope(state: \.chart, action: \.chart) {
            ChartReducer()
        }

        Scope(state: \.accountList, action: \.accountList) {
            TransactionListReducer()
        }
    }
}
