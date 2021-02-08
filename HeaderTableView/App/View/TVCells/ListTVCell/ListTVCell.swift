//
//  ListTVCell.swift
//  HeaderTableView
//
//  Created by K12 Services on 08/02/21.
//

import UIKit

class ListTVCell: UITableViewCell {

    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var listLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        listLabel.numberOfLines = 0
        listLabel.textAlignment = .left
        listView.applyCellView()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
