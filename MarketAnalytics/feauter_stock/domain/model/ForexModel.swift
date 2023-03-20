//
//  CurrencyNameModel.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 14/02/2023.
//

import Foundation

struct ForexModel: Codable {
    var data: [ForexCurrencyModel]
    var status: String
}

struct ForexCurrencyModel: Codable {
    var currency_base: String
    var currency_group: String
    var currency_quote: String
    var symbol: String
}
