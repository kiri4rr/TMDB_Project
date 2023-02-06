//
//  SegmentControlExtension.swift
//  TMDB
//
//  Created by Kirill Romanenko on 05.01.2023.
//

import UIKit

extension UISegmentedControl{
    func setVisible(_ value: Bool, _ myHeight: CGFloat){
        if value {
            self.isHidden = false
        }else {
            self.isHidden = true
        }
        for item in self.constraints {
            if item.firstAttribute == .height{
                item.constant = CGFloat(myHeight)
            }
        }
    }
}
