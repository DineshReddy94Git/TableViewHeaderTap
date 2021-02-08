//
//  ListTableViewVC.swift
//  HeaderTableView
//
//  Created by K12 Services on 08/02/21.
//

import UIKit

typealias JSON = [String: AnyObject]

class ListTableViewVC: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    
    var ContentsModelArray = [ContentsModel]()
    
    let kHeaderSectionTag: Int = 6900;
    var expandedSectionHeaderNumber: Int = -1
    var expandedSectionHeader: UITableViewHeaderFooterView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .red
        navigationController?.navigationBar.backgroundColor = .red
        TableViewUI()
        getContentData()
    }
}
extension ListTableViewVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return ContentsModelArray.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ListHeaderTVCell") as! ListHeaderTVCell
        headerCell.headerNameLabel.text = "City : \(ContentsModelArray[section].city ?? "-NA-"), Weather: \(ContentsModelArray[section].weather ?? "-NA-")"
        
        headerCell.tag = section
        let headerTapGesture = UITapGestureRecognizer()
        headerTapGesture.addTarget(self, action: #selector(ListTableViewVC.sectionHeaderWasTouched(_:)))
        headerCell.addGestureRecognizer(headerTapGesture)
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.expandedSectionHeaderNumber == section) {
            return self.ContentsModelArray[section].hourly_temp?.count ?? 0
        } else {
            return 0;
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTVCell", for: indexPath) as! ListTVCell
        cell.listLabel.text = "Temp: \(ContentsModelArray[indexPath.section].hourly_temp?[indexPath.row].temp ?? 0)"
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 73
    }
    // MARK: - Expand / Collapse Methods
    
    @objc func sectionHeaderWasTouched(_ sender: UITapGestureRecognizer) {
        let headerView = sender.view as! UITableViewHeaderFooterView
        let section    = headerView.tag
        
        if (self.expandedSectionHeaderNumber == -1) {
            self.expandedSectionHeaderNumber = section
            tableViewExpandSection(section)
        } else {
            if (self.expandedSectionHeaderNumber == section) {
                tableViewCollapeSection(section)
            } else {
                tableViewCollapeSection(self.expandedSectionHeaderNumber)
                tableViewExpandSection(section)
            }
        }
    }
    
    func tableViewCollapeSection(_ section: Int) {
        let sectionData = self.ContentsModelArray[section].hourly_temp! as NSArray
        
        self.expandedSectionHeaderNumber = -1;
        if (sectionData.count == 0) {
            return;
        } else {
            var indexesPath = [IndexPath]()
            for i in 0 ..< sectionData.count {
                let index = IndexPath(row: i, section: section)
                indexesPath.append(index)
            }
            self.listTableView!.beginUpdates()
            self.listTableView!.deleteRows(at: indexesPath, with: UITableView.RowAnimation.fade)
            self.listTableView!.endUpdates()
        }
    }
    
    func tableViewExpandSection(_ section: Int) {
        let sectionData = self.ContentsModelArray[section].hourly_temp! as NSArray
        
        if (sectionData.count == 0) {
            self.expandedSectionHeaderNumber = -1;
            return;
        } else {
            var indexesPath = [IndexPath]()
            for i in 0 ..< sectionData.count {
                let index = IndexPath(row: i, section: section)
                indexesPath.append(index)
            }
            self.expandedSectionHeaderNumber = section
            self.listTableView!.beginUpdates()
            self.listTableView!.insertRows(at: indexesPath, with: UITableView.RowAnimation.fade)
            self.listTableView!.endUpdates()
        }
    }
    
}
//MARK:- Private functions
extension ListTableViewVC{
    
    fileprivate func TableViewUI() {
        listTableView.bounces = false
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
    
    func getContentData() {
        JsonManager.sharedInstance.getContentsResponse(onSuccess: {json in
            let array = json as? [JSON]
            for dictionary in array! {
                guard let Menu_Items = ContentsModel(json: dictionary) else { continue }
                self.ContentsModelArray.append(Menu_Items)
            }
            self.listTableView.reloadData()
        })
    }
}
