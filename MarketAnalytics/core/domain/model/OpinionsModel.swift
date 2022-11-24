//
//  OpinionsModel.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 23/11/2022.
//

import Foundation
import SwiftUI

struct OpinionModel: Identifiable {
    let id: String
    let user: UserModel
    let opinion: String
    let date: Date
}
