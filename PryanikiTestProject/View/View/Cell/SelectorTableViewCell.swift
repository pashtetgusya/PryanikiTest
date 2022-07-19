//
//  SelectorTableViewCell.swift
//  PryanikiTestProject
//
//  Created by Pavel Yarovoi on 18.07.2022.
//

import UIKit

class SelectorTableViewCell: UITableViewCell {
    
    private var variantDetails = [Int: String]()
    
    let selector: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)

        return segmentedControl
    }()
    
    let selectorTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        self.addSubview(selector)
        self.contentView.addSubview(selector)
        self.addSubview(selectorTextLabel)
        self.bringSubviewToFront(selector)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private func setupUI() {
        selector.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        selector.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        selector.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        selector.trailingAnchor.constraint(equalTo: selectorTextLabel.leadingAnchor).isActive = true
        
        selectorTextLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        selectorTextLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        selectorTextLabel.leadingAnchor.constraint(equalTo: selector.trailingAnchor).isActive = true
        selectorTextLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    func configureCell(from data: ElementData) {
        if let variants = data.variants {
            selector.removeAllSegments()
            
            variants.forEach { variant in
                let index = variant.id! > 0 ? variant.id! - 1 : 0
                
                selector.insertSegment(withTitle: String(variant.id!), at: index, animated: true)
                if variant.id == data.selectedId! {
                    selector.selectedSegmentIndex = index
                    selectorTextLabel.text = variant.text
                }
                
                variantDetails[index] = variant.text
            }
        }
    }
    
    @objc func segmentedValueChanged(_ sender: AnyObject) {
        selectorTextLabel.text = variantDetails[sender.selectedSegmentIndex]
    }
    
}
