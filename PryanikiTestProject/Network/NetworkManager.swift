//
//  NetworkManager.swift
//  PryanikiTestProject
//
//  Created by Pavel Yarovoi on 18.07.2022.
//

import Foundation
import Alamofire

class NetworkManager {
    
    private let urlString = "https://pryaniky.com/static/json/sample.json"
    
    func fetchData(completion: @escaping(Result<DataList, AFError>) -> Void) {
        AF.request(urlString)
            .validate()
            .responseDecodable(of: DataList.self) { response in
                completion(response.result)
            }
    }
}
