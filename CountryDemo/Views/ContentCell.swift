//
//  ContentCell.swift
//  Country
//
//  Created by Bo Lin on 10/2/18.
//  Copyright © 2018 Bo Lin. All rights reserved.
//

import UIKit
import Kingfisher

class ContentCell: UITableViewCell {
    
    let contentNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    let contentDescrLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        return label
    }()
    
    let contentImageView: CachedImagedView = {
        let imageView = CachedImagedView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 0.8953339041)
        return imageView
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(contentImageView)
        addSubview(contentNameLabel)
        addSubview(contentDescrLabel)
        
        addConstraintsWithFormat(format: "H:|-8-[v0(80)]-8-[v1]-8-|", views: contentImageView, contentNameLabel)
        addConstraintsWithFormat(format: "H:|-8-[v0(80)]-8-[v1]-8-|", views: contentImageView, contentDescrLabel)
        addConstraintsWithFormat(format: "V:|-8-[v0(80)]->=8-|", views: contentImageView)
        addConstraintsWithFormat(format: "V:|-8-[v0]-4-[v1]-8-|", views: contentNameLabel, contentDescrLabel)
    }
    
    // MAKR: - Models
    var content: MTLCountryContent? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        contentImageView.image = nil
        contentNameLabel.text = nil
        contentDescrLabel.text = nil
        
        if let content = self.content {
            contentNameLabel.text = content.title
            contentDescrLabel.text = content.descr
            // TODO: load image async
            if let imageURLString = content.imageHref {
                contentImageView.loadImage(urlString: imageURLString)
            }
        }
    }

}

extension UIView {
    
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}
