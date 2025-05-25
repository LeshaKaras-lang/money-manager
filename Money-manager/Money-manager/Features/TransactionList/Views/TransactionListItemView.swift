//
//  TransactionListItemView.swift
//  Money-manager
//
//  Created by Oleksii Karas on 24.05.2025.
//

import SwiftUI

struct TransactionListView: View {
    
    struct Config: Hashable {
        let title: String
        let description: String
        let amount: String
    }
    
    private let config: Config
    
    init(config: Config) {
        self.config = config
    }
    
    init(transaction: Transaction) {
        self.config = .init(
            title: transaction.accountName,
            description: transaction.description,
            amount: transaction.amount.formatted()
        )
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            leftView
                .fixedSize(horizontal: true, vertical: false)
            middleView
            Spacer()
            rigthView
                .fixedSize(horizontal: true, vertical: false)
        }
        .background(Color.white)
    }
    
    private var leftView: some View {
        Circle()
            .fill(Color.blackOpacity17)
            .frame(width: 48, height: 48)
            .overlay {
                Text("LOGO")
                    .font(.system(size: 14))
                    .foregroundStyle(.white)
            }
            
    }
    
    private var middleView: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(config.title)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(Color.black)
            Text(config.description)
                .font(.system(size: 16))
                .foregroundStyle(Color.lightGray)
        }
        .padding(.horizontal, 16)
    }
    
    private var rigthView: some View {
        Text(config.amount)
            .font(.system(size: 16, weight: .medium))
            .foregroundStyle(Color.black)
    }
}
