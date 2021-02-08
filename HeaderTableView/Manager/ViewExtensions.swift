//
//  ViewExtensions.swift
//  HeaderTableView
//
//  Created by K12 Services on 08/02/21.
//

import Foundation
import UIKit
extension UIView {
    
    func applyHeaderView(){
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 3.0
        self.layer.shadowColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 0.6215494376)

        self.layer.cornerRadius = 5
    }
    func applyCellView(){
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 3.0
        self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        self.layer.cornerRadius = 5
    }
}
