//
//  LogoModel.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 20/02/2023.
//

import Foundation

struct LogoModel: Codable {
    var logo_base: String
    var logo_quote: String
    var meta: LogoSymbolModel
}

struct LogoSymbolModel: Codable {
    var symbol: String
}
