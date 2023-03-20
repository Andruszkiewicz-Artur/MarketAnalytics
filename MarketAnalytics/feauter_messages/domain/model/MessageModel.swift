//
//  MessageModel.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 11/02/2023.
//

import Foundation

struct MessageModel: Hashable {
    var message: String
    var idUser: String
    var username: String?
    var time: String
}
