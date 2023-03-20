//
//  ForexShereModel.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 14/02/2023.
//

import Foundation

struct CurrencyModel: Hashable {
    var name: String
    var logo: String?
    var prize: Double = 0
    var change: Double = 0
    var changeProcent: Double = 0
    var type: WhichTypeCurrency
    var details: CurrencyDetailsModel?
}

struct CurrencyDetailsModel: Hashable {
    var highDay: Double
    var lowDay: Double
    var high52Weeks: Double
    var low52Weeks: Double
    var previousClose: Double
    var open: Double
}

//{
//    "average_volume" = 0;
//    change = "6.44653";
//    close = "2213.65845";
//    datetime = "2023-03-17";
//    exchange = Forex;
//    "fifty_two_week" =     {
//        high = "2294.60107";
//        "high_change" = "-80.94263";
//        "high_change_percent" = "-3.52753";
//        low = "1952.79602";
//        "low_change" = "260.86243";
//        "low_change_percent" = "13.35841";
//        range = "1952.796021 - 2294.601074";
//    };
//    high = "2214.59302";
//    "is_market_open" = 1;
//    low = "2202.64746";
//    name = "Euro Burundian Franc";
//    open = "2207.41797";
//    "percent_change" = "0.29207";
//    "previous_close" = "2207.21191";
//    symbol = "EUR/BIF";
//    timestamp = 1679029560;
//}
