//
//  Transaction.swift
//  Money-manager
//
//  Created by Oleksii Karas on 24.05.2025.
//

import Foundation

struct Transaction: Equatable, Identifiable, Decodable {
    let id: Int
    let date: Date
    let accountName: String
    let description: String
    let amount: Double
}
