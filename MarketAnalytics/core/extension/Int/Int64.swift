//
//  Int64.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 24/11/2022.
//

import Foundation

extension Int64 {
    
    func currentTimeMillis() -> Int64{
        let nowDouble = NSDate().timeIntervalSince1970
        return Int64(nowDouble*1000)
    }
    
}
