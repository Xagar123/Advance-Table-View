//
//  TableCollectionViewCell.swift
//  Advance TableView
//
//  Created by Admin on 21/12/22.
//

import UIKit

class TableCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TableCollectionViewCell"
    
    private let myLable: UILabel = {
        let lable = UILabel()
        lable.textAlignment = .center
        return lable
    }()
    
    private let myImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(myLable)
        contentView.addSubview(myImageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        myImageView.frame = CGRect(x: 5, y: 5, width: contentView.frame.size.width-10, height: contentView.frame.size.height-5-50)
        myLable.frame = CGRect(x: 5, y: contentView.frame.size.height-50, width: contentView.frame.size.width-10, height: 50)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: CollectionTableCellModel) {
        myLable.text = model.title
        myImageView.image = UIImage(named: model.imageName)
    }
    
}
