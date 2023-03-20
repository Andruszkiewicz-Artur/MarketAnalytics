//
//  CryptoModel.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 14/02/2023.
//

import Foundation

struct CryptoModel: Codable {
    var data: [CryptoCurrencyModel]
    var status: String
}

struct CryptoCurrencyModel: Codable {
    var available_exchanges: [String]
    var currency_base: String
    var currency_quote: String
    var symbol: String
}
