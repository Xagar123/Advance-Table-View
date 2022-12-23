//
//  ViewController.swift
//  Advance TableView
//
//  Created by Admin on 21/12/22.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.identifier)
        return table
    }()
    
    private var model = [CellModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.tableHeaderView = createTableHeader()
        tableView.delegate = self
        tableView.dataSource = self
        setUpModels()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createTableHeader()
    }
    private func createTableHeader() -> UIView? {
        guard let path = Bundle.main.path(forResource: "video", ofType: "mp4") else {return nil}
        
        let url = URL(fileURLWithPath: path)
        let player = AVPlayer(url: url)
        player.volume = 0
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width))
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = headerView.bounds
        headerView.layer.addSublayer(playerLayer)
        playerLayer.videoGravity = .resizeAspectFill
        player.play()
        return headerView
    }
    
    private func setUpModels() {
        model.append(.collectionView(models: [CollectionTableCellModel(title: "Car 1", imageName: "car1"),CollectionTableCellModel(title: "Car 2", imageName: "car2"),CollectionTableCellModel(title: "Car 3", imageName: "car1"),
            CollectionTableCellModel(title: "Car 4", imageName: "car2"),
            CollectionTableCellModel(title: "Car 5", imageName: "car1"),
            CollectionTableCellModel(title: "Car 6", imageName: "car2"),
            CollectionTableCellModel(title: "Car 7", imageName: "car1")                                 ],rows: 2))
        
        model.append(.list(models: [ListCellModel(title: "First thing"), ListCellModel(title: "Second things")]))
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch model[section] {
            
        case .collectionView(models: let models, rows: let rows):
            return 2
        case .list(models: let models):
            return models.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch model[indexPath.section] {
        case .collectionView(models: let models, rows: let rows):
            let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as! CollectionTableViewCell
            cell.configure(with: models)
            cell.delegate = self
            return cell
            
        case .list(models: let models):
            let model = models[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = model.title
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("Did selected item")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch model[indexPath.section] {
        case .collectionView(models: let models, rows: let rows):
            return CGFloat(90 * rows)
        case .list(models: let models):
            return 50
        }
    }
}

extension ViewController: CollectionTableViewCellDelegate {
    
    func didSelectItem(with model: CollectionTableCellModel) {
        print("selected\(model.title)")
    }
    
    
}
