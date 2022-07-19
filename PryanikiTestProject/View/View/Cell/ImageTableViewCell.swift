//
//  ImageTableViewCell.swift
//  PryanikiTestProject
//
//  Created by Pavel Yarovoi on 18.07.2022.
//

import UIKit
import Kingfisher

class ImageTableViewCell: UITableViewCell {
    
    private var downloadTask: DownloadTask?
    
    let pictureTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let pictureImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        
        return image
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(pictureTextLabel)
        self.addSubview(pictureImageView)
        
        self.setupUI()
        
        pictureImageView.image = nil
        downloadTask?.cancel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private func setupUI() {
        pictureTextLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        pictureTextLabel.bottomAnchor.constraint(equalTo: pictureImageView.topAnchor).isActive = true
        pictureTextLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        pictureImageView.topAnchor.constraint(equalTo: pictureTextLabel.bottomAnchor).isActive = true
        pictureImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        pictureImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        pictureImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        pictureImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    func configureCell(from data: ElementData) {
        self.pictureTextLabel.text = data.text
        
        if let imageUrlString = data.url, let imageUrl = URL(string: imageUrlString) {
            self.pictureImageView.kf.setImage(with: imageUrl)
        }
    }
}
