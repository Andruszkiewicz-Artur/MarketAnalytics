//
//  ShareViewModel.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 18/02/2023.
//

import Foundation
import OpenAISwift

class ShareViewModel: ObservableObject {
    
    @Published var chatType = ChatModel(isGroup: true, isLive: true, name: "", id: "", lastMessage: "")
    
    @Published var currencyData: [CurrencySimpleDataModel] = []
    @Published var minChart: Double = 0
    @Published var maxChart: Double = 1
    @Published var opinion: OpinionAIEnum = .dontKnow
    @Published var presentInformation: Bool = false
    @Published var information: String = ""
    
    private var client: OpenAISwift?
    
    func setUp(name: String) {
        chatType = ChatModel(isGroup: true, isLive: true, name: name, id: name, lastMessage: "")
        
        getData(symbol: name)
        
        client = OpenAISwift(authToken: "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")
        
        send(text: "Invest in \(name) is current worth? yes or no")
        takeInformationAboutShare(text: "What is \(name)?")
    }
    
    private func getData(symbol: String) {
        let headers = [
            "X-RapidAPI-Key": StaticString.apiKey,
            "X-RapidAPI-Host": "twelve-data1.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://twelve-data1.p.rapidapi.com/time_series?symbol=\(symbol)&interval=1day&outputsize=30&format=json")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { [self] (data, _, error) -> Void in
            guard error == nil, let data = data else {
                print(error ?? "error")
                return
            }
            
            do {
//                let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                let result = try JSONDecoder().decode(CurrentDataModel.self, from: data)
//                for currency in result.data {
//                    forexData.append(CurrencyModel(name: currency.symbol, type: .Forex))
//                }
//                setUpView(type: .Forex)
                
                let currencyData = result.values
                
                var min: Double = Double(currencyData[0].open) ?? 1000
                var max: Double = Double(currencyData[0].open) ?? 0
                                
                currencyData.forEach { data in
                    guard let value = Double(data.open) else {
                        return
                    }
                    
                    if min > value {
                        min = value
                    }
                    
                    if max < value {
                        max = value
                    }
                }
                
                if min < max {
                    minChart = min
                    maxChart = max
                    self.currencyData = currencyData
                }
            } catch {
                print("error")
            }
        })
        
        dataTask.resume()
    }
    
    private func send(text: String) {
        client?.sendCompletion(with: text,
                               maxTokens: 500,
                               completionHandler: { result in
            switch result {
            case .success(let model):
                let output = model.choices.first?.text ?? ""
                print("Opinion ai: \(output)")
                
                if output.lowercased().contains("yes") {
                    self.opinion = .invest
                } else if output.lowercased().contains("no") {
                    self.opinion = .dontInvest
                }
            case .failure:
                    break
            }
        })
    }
    
    private func takeInformationAboutShare(text: String) {
        client?.sendCompletion(with: text,
                               maxTokens: 500,
                               completionHandler: { result in
            switch result {
            case .success(let model):
                let output = model.choices.first?.text ?? ""
                print("Information about share: \(output)")
                self.information = output
            case .failure:
                    break
            }
        })
    }
}
