//
//  CollectionTableViewCell.swift
//  Advance TableView
//
//  Created by Admin on 21/12/22.
//

import UIKit

protocol CollectionTableViewCellDelegate: AnyObject {
    func didSelectItem(with model: CollectionTableCellModel)
}

class CollectionTableViewCell: UITableViewCell {
    
    public weak var delegate: CollectionTableViewCellDelegate?

    static let identifier = "CollectionTableViewCell"
    private let collectionView: UICollectionView
    
    private var model = [CollectionTableCellModel]()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 170, height: 170)
        layout.sectionInset = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout:layout)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        contentView.addSubview(collectionView)
        
        collectionView.register(TableCollectionViewCell.self, forCellWithReuseIdentifier: TableCollectionViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    public func configure(with models: [CollectionTableCellModel]) {
        self.model = models
        collectionView.reloadData()
    }
    
}

extension CollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = model[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TableCollectionViewCell.identifier, for: indexPath) as! TableCollectionViewCell
        
        cell.configure(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = model[indexPath.row]
        collectionView.deselectItem(at: indexPath, animated: true)
        delegate?.didSelectItem(with: model)
    }
    
    
    
}
