//
//  ListHeaderTVCell.swift
//  HeaderTableView
//
//  Created by K12 Services on 08/02/21.
//

import UIKit

class ListHeaderTVCell: UITableViewHeaderFooterView {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        headerNameLabel.numberOfLines = 0
        headerNameLabel.textAlignment = .left
        headerView.applyHeaderView()
        // Initialization code
    }
    
}
