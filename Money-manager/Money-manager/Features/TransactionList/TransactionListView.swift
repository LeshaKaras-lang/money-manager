//
//  TransactionListView.swift
//  Money-manager
//
//  Created by Oleksii Karas on 24.05.2025.
//

import SwiftUI
import ComposableArchitecture
import SwiftUIIntrospect
import UIKit

struct TransactionListSheetView: View {
    let store: StoreOf<TransactionListReducer>

    @GestureState private var dragOffset: CGFloat = 0
    @State private var currentOffset: CGFloat = 0
    
    private let minY: CGFloat
    private let maxY: CGFloat
        
    init(store: StoreOf<TransactionListReducer>, currentOffset: CGFloat, minY: CGFloat, maxY: CGFloat) {
        self.store = store
        self.currentOffset = currentOffset
        self.minY = minY
        self.maxY = maxY
    }
    
    var body: some View {
        WithViewStore(store, observe: \.self) { viewStore in
            VStack(alignment: .center, spacing: 0) {
                capsuleView
                titleView
                contentView(for: viewStore.transactions)
            }
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(20)
            .offset(y: max(0, currentOffset + dragOffset))
            .gesture(
                DragGesture()
                    .updating($dragOffset) { value, state, _ in
                        state = value.translation.height
                    }
                    .onEnded { value in
                        let newOffset = currentOffset + value.translation.height
                        currentOffset = newOffset.closest(between: minY, and: maxY)
                    }
            )
            .animation(.easeInOut, value: dragOffset)
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
    
    private var capsuleView: some View {
        Capsule()
            .frame(width: 54, height: 4)
            .foregroundColor(Color.blackOpacity17)
            .padding(.top, 8)
    }
    
    private var titleView: some View {
        HStack(alignment: .center, spacing: 0) {
            Text("Accounts")
                .font(.system(size: 20, weight: .medium))
                .padding(.top, 28)
                .padding(.horizontal, 20)
            Spacer()
        }
    }
    
    private func contentView(for transactions: [Transaction]) -> some View {
        List {
            ForEach(transactions) { transaction in
                TransactionListView(transaction: transaction)
                    .listRowSeparator(.visible)
            }
        }
        .listStyle(.plain)
    }
}
