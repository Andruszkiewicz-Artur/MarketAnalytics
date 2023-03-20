//
//  StackDataService.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 14/02/2023.
//

import Foundation
import Combine

class StackDataService {
    @Published var currencyForex: [CurrencyModel] = []
    
    init() {
        getData()
    }
    
    func getData() {
        
        let headers = [
            "X-RapidAPI-Key": "a989330f8emsh32bf2225ba6bed5p189908jsn02304c89d5ad",
            "X-RapidAPI-Host": "twelve-data1.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://twelve-data1.p.rapidapi.com/forex_pairs?currency_base=EUR&format=json")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { [self] (data, _, error) -> Void in
            guard error == nil, let data = data else {
                print(error!)
                return
            }
            
            do {
//                let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                let result = try JSONDecoder().decode(ForexModel.self, from: data)
                for currency in result.data {
                    currencyForex.append(CurrencyModel(name: currency.symbol))
                }
            } catch {
                print("error")
            }
        })
        
        session.dataTask(with: request as URLRequest)
            .subscribe(on: DispatchQueue.global(.default))
            .tryMap {  in
                <#code#>
            }
    }
    
}
