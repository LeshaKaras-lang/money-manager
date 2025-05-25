//
//  AppView.swift
//  Money-manager
//
//  Created by Oleksii Karas on 24.05.2025.
//

import SwiftUI
import ComposableArchitecture

struct AppView: View {
    let store: StoreOf<AppReducer>
    
    @State private var showSheet = true
    
    var body: some View {
        NavigationStack{
            GeometryReader { proxy in
                ZStack(alignment: .top) {
                    Color.darkGreen
                        .edgesIgnoringSafeArea(.all)
                    ChartView(
                        store: store.scope(state: \.chart, action: \.chart)
                    )
                    .frame(height: calculateChartViewHeight(height: proxy.size.height))
                    TransactionListSheetView(
                        store: store.scope(state: \.accountList, action: \.accountList),
                        currentOffset: calculateChartViewHeight(height: proxy.size.height),
                        minY: 0,
                        maxY: calculateChartViewHeight(height: proxy.size.height)
                    )
                    .edgesIgnoringSafeArea(.bottom)
                }
                .navigationTitle("Statistics")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
    
    private func calculateChartViewHeight(height: CGFloat) -> CGFloat {
        height * 0.55
    }
}
