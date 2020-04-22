//
//  FeedView.swift
//  Fast News
//
//  Copyright © 2019 Lucas Moreton. All rights reserved.
//

import UIKit

protocol FeedViewDelegate {
    func didTouch(cell: FeedCell, indexPath: IndexPath)
    func loadItens()
}

extension FeedViewDelegate
{
    func loadItens(){}
}

class FeedView: UIView {
    
    //MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    var viewModels: [HotNewsViewModel] = [HotNewsViewModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    var delegate: FeedViewDelegate?
    
    //MARK: - Public Methods
    
    
    func setup(with delegate: FeedViewDelegate) {
        tableView.estimatedRowHeight = 260.0
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(UINib(nibName: "FeedCell", bundle: Bundle.main), forCellReuseIdentifier: "FeedCell")
        tableView.register(UINib(nibName: "LoadingCell", bundle: Bundle.main), forCellReuseIdentifier: "LoadingCell")
        
        self.delegate = delegate
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.reloadData()
    }
    
    func updateView(with viewModels: [HotNewsViewModel]) {
        self.viewModels.append(contentsOf: viewModels)
    }
}

extension FeedView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count + 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == viewModels.count
        {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath) as? LoadingCell else { fatalError("Cell is not of type FeedCell!") }
            cell.startLoading()
            self.delegate?.loadItens()
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as? FeedCell else { fatalError("Cell is not of type FeedCell!") }
        
        cell.setup(hotNewsViewModel: viewModels[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? FeedCell else { fatalError("Cell is not of type FeedCell!") }
        if indexPath.row == viewModels.count
        {
            return
        }
        delegate?.didTouch(cell: cell, indexPath: indexPath)
    }
}
