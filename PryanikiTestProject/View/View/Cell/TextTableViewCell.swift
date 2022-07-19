//
//  TextTableViewCell.swift
//  PryanikiTestProject
//
//  Created by Pavel Yarovoi on 18.07.2022.
//

import UIKit

class TextTableViewCell: UITableViewCell {
    
    let hzTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(hzTextLabel)
        
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
        hzTextLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        hzTextLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        hzTextLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true

    }
    
    func configureCell(from data: ElementData) {
        self.hzTextLabel.text = data.text
    }

}
