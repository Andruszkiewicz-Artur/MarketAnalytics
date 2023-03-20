//
//  CurrentDataModel.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 17/03/2023.
//

import Foundation

struct CurrentDataModel: Decodable {
    var meta: CurrencyMetaModel
    var status: String
    var values: [CurrencySimpleDataModel]
}

struct CurrencyMetaModel: Decodable {
    var currency_base: String
    var currency_quote: String
    var interval: String
    var symbol: String
    var type: String
}

struct CurrencySimpleDataModel: Decodable, Identifiable {
    var id: String {
        datetime
    }
    var close: String
    var datetime: String
    var high: String
    var low: String
    var open: String
}
