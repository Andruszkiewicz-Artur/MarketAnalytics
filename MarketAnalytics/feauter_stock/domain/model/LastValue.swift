//
//  LastValue.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 04/03/2023.
//

import Foundation

struct CurrencyLastValueModel: Codable {
    var average_volume: String
    var change: String
    var close: String
    var datetime: String
    var exchange: String
    var fifty_two_week: FiftyTwoWeekModel
    var high: String
    var is_market_open: String
    var low: String
    var name: String
    var open: String
    var percent_change: String
    var previous_close: String
//    var rolling_1d_change: String?
//    var rolling_7d_change: String?
//    var rolling_change: String?
    var symbol: String
    var timestamp: String
}

struct FiftyTwoWeekModel: Codable {
    var high: String
    var high_change: String
    var high_change_percent: String
    var low: String
    var low_change: String
    var low_change_percent: String
    var range: String
}


//808/USD: {
//    "average_volume" = 0;
//    change = "-0.00000";
//    close = "0.00000";
//    datetime = "2023-03-04";
//    exchange = Synthetic;
//    "fifty_two_week" =     {
//        high = "0.00001";
//        "high_change" = "-0.00000";
//        "high_change_percent" = "-52.80528";
//        low = "0.00000";
//        "low_change" = "0.00000";
//        "low_change_percent" = "51.05634";
//        range = "0.000003 - 0.000009";
//    };
//    high = "0.00000";
//    "is_market_open" = 1;
//    low = "0.00000";
//    name = "808Coin US Dollar";
//    open = "0.00000";
//    "percent_change" = "-2.94118";
//    "previous_close" = "0.00000";
//    "rolling_1d_change" = "-2.50000";
//    "rolling_7d_change" = "-5.92105";
//    "rolling_change" = "-2.50000";
//    symbol = "808/USD";
//    timestamp = 1677961646;
//}

//{
//    "average_volume" = 0;
//    change = "0.01655";
//    close = "3.90670";
//    datetime = "2023-03-03";
//    exchange = Forex;
//    "fifty_two_week" =     {
//        high = "4.10845";
//        "high_change" = "-0.20175";
//        "high_change_percent" = "-4.91061";
//        low = "3.50240";
//        "low_change" = "0.40430";
//        "low_change_percent" = "11.54351";
//        range = "3.502400 - 4.108450";
//    };
//    high = "3.90670";
//    "is_market_open" = 0;
//    low = "3.88850";
//    name = "Euro UAE Dirham";
//    open = "3.89015";
//    "percent_change" = "0.42543";
//    "previous_close" = "3.89015";
//    symbol = "EUR/AED";
//    timestamp = 1677873576;
//}
