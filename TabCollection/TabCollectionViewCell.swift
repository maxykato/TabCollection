//
//  TabCollectionViewCell.swift
//  TabCollection
//
//  Created by Yuichi Max Kato on 2015/11/22.
//  Copyright © 2015年 Yuichi Kato. All rights reserved.
//

import UIKit

class TabCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tabTitle: UILabel!
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
    }
    
}
