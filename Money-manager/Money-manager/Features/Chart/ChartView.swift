//
//  ChartView.swift
//  Money-manager
//
//  Created by Oleksii Karas on 24.05.2025.
//

import SwiftUI
import Charts
import ComposableArchitecture

struct ChartView: View {
    typealias ChartViewStore = ViewStore<ChartReducer.State, ChartReducer.Action>
    
    let store: StoreOf<ChartReducer>

    var body: some View {
        WithViewStore(store, observe: \.self) { viewStore in
            VStack(alignment: .leading) {
                headerView
                chartView(for: viewStore)
                datePicker(for: viewStore)
            }
            .onAppear {
                store.send(.onAppear)
            }
        }
    }
    
    private var headerView: some View {
        VStack(alignment: .center, spacing: 0) {
            Text("Chart")
                .font(.title)
            Text("Transactions per period")
                .font(.caption)
        }
    }
    
    private func datePicker(for viewStore: ChartViewStore) -> some View {
        Picker("Period", selection: viewStore.binding(get: \.selectedPeriod, send: ChartReducer.Action.periodChanged)) {
            ForEach(ChartReducer.Period.allCases, id: \.self) {
                Text($0.rawValue)
            }
        }
        .pickerStyle(.segmented)
    }
    
    private func chartView(for viewStore: ChartViewStore) -> some View {
        Chart {
            ForEach(filteredData(for: viewStore)) { point in
                LineMark(
                    x: .value("Date", point.date),
                    y: .value("Value", point.amount)
                )
                .interpolationMethod(.catmullRom)
                .foregroundStyle(Color.lightGreen)
                .lineStyle(StrokeStyle(lineWidth: 3))
            }
        }
        .chartXAxis {
            AxisMarks(values: .stride(by: .day)) { value in
                AxisGridLine()
                AxisValueLabel(format: .dateTime.day().month())
            }
        }
        .chartYAxis {
            AxisMarks(position: .leading)
        }
        .padding()
    }

    func filteredData(for viewStore: ChartViewStore) -> [Transaction] {
        let data = viewStore.transactions.sorted { $0.date < $1.date }
        switch viewStore.selectedPeriod {
        case .week:
            return Array(data.suffix(7))
        case .month:
            return Array(data.suffix(30))
        case .year:
            return data
        }
    }

    func dateString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

#Preview {
    ChartView(
        store: .init(
            initialState: ChartReducer.State(),
            reducer: { ChartReducer() }
        )
    )
    .frame(height: 300)
}
