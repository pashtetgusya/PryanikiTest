//
//  PryanikiViewModel.swift
//  PryanikiTestProject
//
//  Created by Pavel Yarovoi on 18.07.2022.
//

import Foundation


class PryanikiViewModel: NSObject {
    
    private let networkManager = NetworkManager()
    
    var bindPryanikiViewModelToController : (() -> ()) = {}
    var error: String?
    var result: [Element]? {
        didSet {
            self.bindPryanikiViewModelToController()
        }
    }

    override init() {
        super.init()
        getData()
    }
        
    func getData() {
        networkManager.fetchData { responce in
            switch responce {
            case .success(let receivedData):
                let elements = receivedData.view?.compactMap { elementType in
                    receivedData.data?.first { $0.name == elementType}
                }
                self.result = elements
                self.error = nil
            case .failure(let error):
                self.error = error.localizedDescription
                self.bindPryanikiViewModelToController()
            }
        }
    }

}
