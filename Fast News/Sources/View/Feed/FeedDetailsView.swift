//
//  FeedDetailsView.swift
//  Fast News
//
//  Copyright © 2019 Lucas Moreton. All rights reserved.
//

import UIKit

class FeedDetailsView: UIView {
    
    //MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    var commentIsLoaded = false
    
    var viewModels: [TypeProtocol] = [TypeProtocol]() {
        didSet {
            tableView.reloadData()
        }
    }
    var delegate: FeedViewDelegate?
    
    //MARK: - Public Methods
    
    func setup(with viewModels: [TypeProtocol], and delegate: FeedViewDelegate) {
        tableView.estimatedRowHeight = 400
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(UINib(nibName: "FeedCell", bundle: Bundle.main), forCellReuseIdentifier: "FeedCell")
        tableView.register(UINib(nibName: "CommentCell", bundle: Bundle.main), forCellReuseIdentifier: "CommentCell")
        
        tableView.register(UINib(nibName: "LoadingCell", bundle: Bundle.main), forCellReuseIdentifier: "LoadingCell")
        
        self.delegate = delegate
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = .white
        
        self.viewModels = viewModels

    }
    
    func updateView(with viewModels: [TypeProtocol]) {
        commentIsLoaded = true
        self.viewModels = viewModels
    }
}

extension FeedDetailsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !commentIsLoaded
        {
            return viewModels.count + 1
        }
        
        return viewModels.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 1 && !commentIsLoaded
        {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath) as? LoadingCell else { fatalError("Cell is not of type FeedCell!") }
            cell.startLoading()
            return cell
        }
        
        let viewModel = viewModels[indexPath.row]
        
        switch viewModel.type {
        case .hotNews:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as? FeedCell else { fatalError("Cell is not of type FeedCell!") }
            
            cell.setup(viewModel: viewModel)
            
            return cell
        case .comment:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as? CommentCell else { fatalError("Cell is not of type CommentCell!") }
            
            cell.setup(viewModel: viewModel)
            
            return cell
        }
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = viewModels[indexPath.row]
        
        switch viewModel.type {
        case .hotNews:
            guard let cell = tableView.cellForRow(at: indexPath) as? FeedCell else { fatalError("Cell is not of type FeedCell!") }
            
            delegate?.didTouch(cell: cell, indexPath: indexPath)
        case .comment:
            return
        }
    }
}

