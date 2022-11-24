//
//  UserModel.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 22/11/2022.
//

import Foundation
import SwiftUI

struct UserModel: Identifiable {
    let id: String
    var userName: String
    var image: Data?
    var likes: Int
    var dislikes: Int
    var description: String
    var isAdmin: Bool
    var opinions: [OpinionModel]
}
