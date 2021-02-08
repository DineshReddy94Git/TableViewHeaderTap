//
//  ListTableViewVC.swift
//  HeaderTableView
//
//  Created by K12 Services on 08/02/21.
//

import UIKit

class ListTableViewVC: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableViewUI()
    }
}
extension ListTableViewVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ListHeaderTVCell") as! ListHeaderTVCell
        headerCell.headerNameLabel.text = "Header cell \(section)"
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTVCell", for: indexPath) as! ListTVCell
        cell.listLabel.text = "TVCell \(indexPath.section) - \(indexPath.row)"
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 73
    }
    
}
//MARK:- Private functions
extension ListTableViewVC{
    
    fileprivate func TableViewUI() {
        listTableView.delegate = self
        listTableView.dataSource = self
        
        //MARK: Set estimated height
        self.listTableView.sectionHeaderHeight = UITableView.automaticDimension
        self.listTableView.estimatedSectionHeaderHeight = 73
        
        listTableView.tableFooterView = UIView()
        listTableView.separatorStyle = .none
        
        //MARK: Register cell
        let headerCell = UINib(nibName: "ListHeaderTVCell", bundle: nil)
        listTableView.register(headerCell, forHeaderFooterViewReuseIdentifier: "ListHeaderTVCell")
        let listCell = UINib(nibName: "ListTVCell", bundle: nil)
        listTableView.register(listCell, forCellReuseIdentifier: "ListTVCell")
    }
}
