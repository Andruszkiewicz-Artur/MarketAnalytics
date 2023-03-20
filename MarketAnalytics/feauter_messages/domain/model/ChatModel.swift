//
//  ChatModel.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 11/02/2023.
//

import Foundation

struct ChatModel: Hashable {
    var isGroup: Bool
    var isLive: Bool?
    var name: String
    var id: String
    var lastMessage: String
    var adminId: String?
}
