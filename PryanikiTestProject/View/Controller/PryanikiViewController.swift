//
//  PryanikiViewController.swift
//  PryanikiTestProject
//
//  Created by Pavel Yarovoi on 18.07.2022.
//

import UIKit

class PryanikiViewController: UIViewController {

    private let pryanikiView = PryanikiView()
    private var viewModel = PryanikiViewModel()
    private let networkManager = NetworkManager()
    
    private var elements = [Element]()
    private var isRefreshing = false
    
    override func loadView() {
        view = pryanikiView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Тестовое задание Pryaniki"
        
        self.pryanikiView.tableView.dataSource = self
        self.pryanikiView.tableView.delegate = self
        self.pryanikiView.tableView.refreshControl?.addTarget(self, action: #selector(callPullToRefresh), for: .valueChanged)
        
        self.callViewModelForUIUpdate()
    }
    
    @objc private func callPullToRefresh() {
        isRefreshing = true
        callViewModelForUIUpdate()
    }
    
    private func callViewModelForUIUpdate() {
        self.viewModel = PryanikiViewModel()
        
        self.viewModel.bindPryanikiViewModelToController = {
            DispatchQueue.main.async {
                if self.isRefreshing {
                    self.isRefreshing = false
                    self.pryanikiView.tableView.refreshControl?.endRefreshing()
                }
                
                if self.viewModel.error == nil {
                    guard let viewModelData = self.viewModel.result else {
                        return
                    }
                    self.elements = viewModelData
                    self.pryanikiView.tableView.reloadData()
                } else {
                    self.showAlert(message: self.viewModel.error ?? "Кажется возникли небольшие неполадки")
                }
            }
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let alertOkAction = UIAlertAction(title: "Ок", style: .default)
        
        alert.addAction(alertOkAction)
    
        present(alert, animated: true)
    }
    
}

extension PryanikiViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentElement = elements[indexPath.row]
        
        switch currentElement.name {
        case "selector":
            let cell = tableView.dequeueReusableCell(withIdentifier: "selectorCell", for: indexPath) as! SelectorTableViewCell
            cell.configureCell(from: currentElement.data!)
            return cell
        case "picture":
            let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! ImageTableViewCell
            cell.configureCell(from: currentElement.data!)
            return cell
        case "hz":
            let cell = tableView.dequeueReusableCell(withIdentifier: "textCell", for: indexPath) as! TextTableViewCell
            cell.configureCell(from: currentElement.data!)
            return cell
        default:
            return UITableViewCell()
        }
            
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let alertMessage = "Событие инициализировал элемент '\(elements[indexPath.row].name!)'"
        self.showAlert(message: alertMessage)
    }

}
