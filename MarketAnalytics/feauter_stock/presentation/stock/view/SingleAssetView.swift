//
//  SingleAssetView.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 18/02/2023.
//

import SwiftUI

struct SingleAssetView: View {
    
    let asset: CurrencyModel
    
    init(asset: CurrencyModel) {
        self.asset = asset
    }
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: asset.logo ?? "")) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .cornerRadius(25)
            } placeholder: {
                Circle()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.gray)
            }

            
            VStack {
                HStack {
                    Text(asset.name)
                        .foregroundColor(.primary)
                    Spacer()
                    if asset.prize != 0 {
                        Text(String(format: "%.4f", asset.prize))
                            .foregroundColor(.primary)
                    } else {
                        Text("-")
                    }
                }
                Spacer()
                HStack {
                    ZStack {
                        Circle()
                            .frame(width: 25, height: 25)
                            .foregroundColor(asset.change == 0 ? .gray : asset.change > 0 ? .theme.green : .theme.red)
                        
                        if asset.change == 0 {
                            Text("-")
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                        } else {
                            if asset.change > 0 {
                                Image(systemName: "arrow.up")
                                    .foregroundColor(.white)
                                    .font(.system(size: 20))
                            } else {
                                Image(systemName: "arrow.down")
                                    .foregroundColor(.white)
                                    .font(.system(size: 20))
                            }
                        }
                    }
                    Spacer()
                    Text(String(format: "%.3f(%.2f)", asset.change, asset.changeProcent))
                        .foregroundColor(asset.change == 0 ? .gray : asset.change > 0 ? .theme.green : .theme.red)
                }
            }
        }
    }
    
    private func power(num: Int, exponent: Int) -> Int {
        var result = num
        for _ in Range(0...exponent) {
            result = result * num
        }
        
        return result
    }
}
