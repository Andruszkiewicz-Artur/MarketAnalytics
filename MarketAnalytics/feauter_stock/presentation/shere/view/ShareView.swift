//
//  ShareView.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 18/02/2023.
//

import SwiftUI
import Charts

struct ShareView: View {
    
    @StateObject private var vm: ShareViewModel = ShareViewModel()
    
    var currency: CurrencyModel
    
    init(currency: CurrencyModel) {
        self.currency = currency
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(currency.name)
                .font(.system(size: 30))
            
            HStack {
                if currency.changeProcent > 0 {
                    Image(systemName: "arrow.up")
                        .foregroundColor(.theme.green)
                        .font(.system(size: 24))
                } else if currency.changeProcent < 0 {
                    Image(systemName: "arrow.down")
                        .foregroundColor(.theme.red)
                        .font(.system(size: 24))
                } else {
                    Text("-")
                        .foregroundColor(.gray)
                        .font(.system(size: 24))
                }
                
                Text(String(format: "%.4f", currency.prize))
                    .font(.system(size: 26))
                
                Text(String(format: "%.3f(%.2f)", currency.change, currency.changeProcent))
                    .foregroundColor(currency.change == 0 ? .gray : currency.change > 0 ? .theme.green : .theme.red)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                Chart(vm.currencyData) { data in
                    LineMark(
                        x: .value("Data", data.datetime),
                        y: .value("Prize", Double(data.open) ?? 0)
                    )
                    .foregroundStyle(Color.theme.accent)
                }
                .frame(width: 3000)
            }
            .chartYScale(domain: vm.minChart...vm.maxChart)
            .frame(height: 300)
            
            if let details = currency.details {
                VStack {
                    HStack {
                        Text("Day`s range")
                        Spacer()
                        Text(String(format: "%.4f - %.4f", details.lowDay, details.highDay))
                            .foregroundColor(.gray)
                    }
                    
                    HStack {
                        Text("52wk range")
                        Spacer()
                        Text(String(format: "%.4f - %.4f", details.low52Weeks, details.low52Weeks))
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text("Open")
                        Spacer()
                        Text(String(format: "%.3f", details.open))
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text("Previous close")
                        Spacer()
                        Text(String(format: "%.3f", details.previousClose))
                            .foregroundColor(.gray)
                    }
                }
                .font(.system(size: 20))
            }
            
            VStack {
                HStack {
                    Text("Is it worth buying an asset(Opinion)?")
                        .foregroundColor(.gray)
                    Spacer()
                }
                HStack {
                    Text("Opinion AI:")
                    Spacer()
                    if vm.opinion == .invest {
                        Text("Invest")
                            .foregroundColor(.theme.green)
                    } else if vm.opinion == .dontKnow {
                        Text("Don`t Know")
                            .foregroundColor(.gray)
                    } else {
                        Text("Don`t Invest")
                            .foregroundColor(.theme.red)
                    }
                }
                .font(.system(size: 20))
            }
            .padding(.vertical)
            
            NavigationLink(value: vm.chatType) {
                liveChatView()
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .navigationTitle(currency.type.rawValue)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            vm.setUp(name: currency.name)
        }
    }
}
