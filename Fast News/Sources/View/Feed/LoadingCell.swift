//
//  LoadingCell.swift
//  Fast News
//
//  Created by HST Apple on 21/04/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import UIKit

class LoadingCell: UITableViewCell {
    
    //MARK: - Properties
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func startLoading()
    {
        activityIndicator.startAnimating()
    }
    
}
