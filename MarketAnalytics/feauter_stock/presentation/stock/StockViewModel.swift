//
//  StockViewModel.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 10/02/2023.
//

import Foundation
import Combine

class StockViewModel: ObservableObject {
    
    @Published var searchValue: String = "" {
        willSet {
            if newValue == "" {
                setType(value: whichTypeCurrency)
            } else {
                var afterSearch: [CurrencyModel] = []
                
                if whichTypeCurrency == .Forex {
                    forexData.forEach { currency in
                        if currency.name.lowercased().contains(searchValue.lowercased()) {
                            afterSearch.append(currency)
                        }
                    }
                    stockList = afterSearch
                } else {
                    cryptoData.forEach { currency in
                        if currency.name.lowercased().contains(searchValue.lowercased()) {
                            afterSearch.append(currency)
                        }
                    }
                    
                    stockList = afterSearch
                }
            }
        }
    }
    @Published var whichTypeCurrency: WhichTypeCurrency = .Forex {
        willSet {
            setType(value: newValue)
            
            chatType = ChatModel(isGroup: true, isLive: true, name: newValue.rawValue, id: newValue.rawValue, lastMessage: "")
        }
    }
    @Published var chatType = ChatModel(isGroup: true, isLive: true, name: WhichTypeCurrency.Forex.rawValue, id: WhichTypeCurrency.Forex.rawValue, lastMessage: "")
    
    private func setType(value: WhichTypeCurrency) {
        setUpView(type: value)
        
        if searchValue != "" {
            searchValue = ""
        }
    }
    
    private func setUpView(type: WhichTypeCurrency) {
        var list: [CurrencyModel] = []
        
        if type == .Forex {
            list = forexData
        } else if type == .Crypto {
            list = cryptoData
        }
        
        stockList = []
        
        let count = list.count >= 10 ? 10 : list.count - 1
        
        if list.count > 0 {
            for i in Range(0...count) {
                stockList.append(list[i])
                searchSymbol(symbol: list[i].name)
                checkValue(symbol: list[i].name)
            }
        }
    }
    
    @Published var stockList: [CurrencyModel] = []
    private var forexData: [CurrencyModel] = []
    private var cryptoData: [CurrencyModel] = []
    
    init() {
        getForexData()
        getCryptoData()
    }
    
    func getForexData() {
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
                print(error ?? "error")
                return
            }
            
            do {
//                let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                let result = try JSONDecoder().decode(ForexModel.self, from: data)
                for currency in result.data {
                    forexData.append(CurrencyModel(name: currency.symbol, type: .Forex))
                }
                setUpView(type: .Forex)
            } catch {
                print("error")
            }
        })
        
        dataTask.resume()
    }
    
    func getCryptoData() {
        let headers = [
            "X-RapidAPI-Key": "a989330f8emsh32bf2225ba6bed5p189908jsn02304c89d5ad",
            "X-RapidAPI-Host": "twelve-data1.p.rapidapi.com"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://twelve-data1.p.rapidapi.com/cryptocurrencies")! as URL,
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
                let result = try JSONDecoder().decode(CryptoModel.self, from: data)
            
                for currency in result.data {
                    cryptoData.append(CurrencyModel(name: currency.symbol, type: .Crypto))
                }
                
            } catch {
                print("error")
            }
        })

        dataTask.resume()
    }
    
    private func searchSymbol(symbol: String) {
        let headers = [
            "X-RapidAPI-Key": "a989330f8emsh32bf2225ba6bed5p189908jsn02304c89d5ad",
            "X-RapidAPI-Host": "twelve-data1.p.rapidapi.com"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://twelve-data1.p.rapidapi.com/logo?symbol=\(symbol)")! as URL,
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
                let result = try JSONDecoder().decode(LogoModel.self, from: data)
                
                var newData: [CurrencyModel] = []
                
                if whichTypeCurrency == .Forex {
                    forexData.forEach { currency in
                        if currency.name == symbol {
                            newData.append(CurrencyModel(name: currency.name, logo: result.logo_quote, prize: currency.prize, change: currency.change, changeProcent: currency.changeProcent, type: currency.type))
                        } else {
                            newData.append(currency)
                        }
                    }
                    
                    forexData = newData
                } else {
                    cryptoData.forEach { currency in
                        if currency.name == symbol {
                            newData.append(CurrencyModel(name: currency.name, logo: result.logo_quote, prize: currency.prize, change: currency.change, changeProcent: currency.changeProcent, type: currency.type))
                        } else {
                            newData.append(currency)
                        }
                    }
                    
                    cryptoData = newData
                }
                
            } catch {
                print("error with taking data")
            }
        })

        dataTask.resume()
    }
    
    private func checkValue(symbol: String) {
        let headers = [
            "X-RapidAPI-Key": "a989330f8emsh32bf2225ba6bed5p189908jsn02304c89d5ad",
            "X-RapidAPI-Host": "twelve-data1.p.rapidapi.com"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://twelve-data1.p.rapidapi.com/quote?symbol=\(symbol)&interval=1day&outputsize=30&format=json")! as URL,
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
                let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//                let result = try JSONDecoder().decode(CurrencyLastValueModel.self, from: data)
//                print("\(result)")
                
                
                guard let value = result as? NSDictionary else {
                    return
                }
                var newData: [CurrencyModel] = []
                
                guard let weeksDetails = value["fifty_two_week"] as? NSDictionary else {
                    return
                }
                
                guard let change = Double(value["change"] as? String ?? ""),
                      let prize = Double(value["open"] as? String ?? ""),
                      let procentChange = Double(value["percent_change"] as? String ?? ""),
                        let highWeeks = Double(weeksDetails["high"] as? String ?? ""),
                        let lowWeeks = Double(weeksDetails["low"] as? String ?? ""),
                      let high = Double(value["high"] as? String ?? ""),
                        let low = Double(value["low"] as? String ?? ""),
                      let close = Double(value["close"] as? String ?? ""),
                      let open = Double(value["open"] as? String ?? "") else {
                    return
                }
                
                var details: CurrencyDetailsModel = CurrencyDetailsModel(highDay: high, lowDay: low, high52Weeks: highWeeks, low52Weeks: lowWeeks, previousClose: close, open: open)
                
                if whichTypeCurrency == .Forex {
                    forexData.forEach { currency in
                        if currency.name == symbol {
                            newData.append(CurrencyModel(name: currency.name, logo: currency.logo, prize: prize, change: change, changeProcent: procentChange, type: currency.type, details: details))
                        } else {
                            newData.append(currency)
                        }
                    }

                    forexData = newData
                } else {
                    cryptoData.forEach { currency in
                        if currency.name == symbol {
                            newData.append(CurrencyModel(name: currency.name, logo: currency.logo, prize: prize, change: change, changeProcent: procentChange, type: currency.type, details: details))
                        } else {
                            newData.append(currency)
                        }
                    }

                    cryptoData = newData
                }
                
            } catch {
                print("error with taking data")
            }
        })

        dataTask.resume()
    }
}
