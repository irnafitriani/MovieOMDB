//
//  ColumnFlowLayout.swift
//  MovieOMDB
//
//  Created by irna on 12/10/18.
//  Copyright © 2018 irna. All rights reserved.
//

import UIKit

class ColumnFlowLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        
        guard let cv = collectionView else {return}
        
        let availableWidth = cv.bounds.insetBy(dx: cv.layoutMargins.right, dy: cv.layoutMargins.top).size.width
        let minColumnWidth = CGFloat(300.0)
        let maxNumColumns = Int (availableWidth / minColumnWidth)
        let cellWidth = (availableWidth / CGFloat(maxNumColumns)).rounded(.down)
        
        self.itemSize = CGSize(width: cellWidth, height: 70.0)
        
        
        self.sectionInset = UIEdgeInsets(top: self.minimumInteritemSpacing, left: 0.0, bottom: 0.0, right: 0.0)
        if #available(iOS 11.0, *) {
            self.sectionInsetReference = .fromSafeArea
        } else {
            // Fallback on earlier versions
        }
        
    }

}
