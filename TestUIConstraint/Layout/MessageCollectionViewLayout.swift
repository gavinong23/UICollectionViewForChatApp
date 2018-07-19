//
//  MessageCollectionViewLayout.swift
//  TestUIConstraint
//
//  Created by Gavin Ong on 18/7/18.
//  Copyright © 2018 Gavin Ong. All rights reserved.
//

import Foundation
import UIKit


protocol MessageCollectionViewLayoutDelegate {
    func collectionView(collectionView: UICollectionView, heightForItemAtIndexPath indexPath: IndexPath) -> CGFloat
    
    func collectionView(collectionView:UICollectionView, widthForItemAtIndexPath indexPath: IndexPath) -> CGFloat
    
    
    func isSender(indexPath: IndexPath) -> Bool
}
class MessageCollectionViewLayout: UICollectionViewLayout{
    
    
    var delegate: MessageCollectionViewLayoutDelegate!
    
    var numberOfColumns: Int = 1
    
    private var cache = [UICollectionViewLayoutAttributes]()
    
    private var contentHeight: CGFloat = 0
    
    private var contentWidth: CGFloat = 0
    
    private var width: CGFloat{
        get{
            let insets = collectionView!.contentInset
            return self.collectionView!.frame.width - (insets.left + insets.right)
        
        }
    }
    
    override var collectionViewContentSize: CGSize{
        return CGSize(width: contentWidth + 5, height: contentHeight)
    }
    
    override func prepare(){
        if cache.isEmpty{
            
            //This is the full screen width for particular columns number
            
            let columnWidth = width / CGFloat(numberOfColumns)
            
            var xOffsets = [CGFloat]() // couple of arrayhold the x and y offset of each frame got a reference
            
            for column in 0..<numberOfColumns{
                xOffsets.append(CGFloat(column) * columnWidth)
            }
     
            var yOffsets = [CGFloat](repeating: 0, count: numberOfColumns)
            
            var column = 0
            
            for item in 0..<collectionView!.numberOfItems(inSection: 0){
                
                let indexPath = IndexPath(item: item, section: 0)
                
                let height = delegate.collectionView(collectionView: collectionView!, heightForItemAtIndexPath: indexPath)
                    
                let width = delegate.collectionView(collectionView: collectionView!, widthForItemAtIndexPath: indexPath)
            
                let frame = CGRect(x: xOffsets[column], y: yOffsets[column], width: width, height: height)
                
//                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
                
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                    
                attributes.frame = frame
                
//                attributes.frame = insetFrame
             
                cache.append(attributes)
                    
                contentHeight = max(contentHeight, frame.maxY)
                    
                yOffsets[column] = yOffsets[column] + height
                    
                column = column >= (numberOfColumns - 1) ? 0 : column + 1
                
            }
            
            
        }
    }
    
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
       // var leftMargin = self.collectionView.sectionInse
        
        
        for attributes in cache{
            if attributes.frame.intersects(rect){
                
                if !delegate.isSender(indexPath: attributes.indexPath){
                    attributes.frame.origin.x = 5
                    
                    collectionView?.translatesAutoresizingMaskIntoConstraints = false
                }else{
                    
                    print(self.collectionView!.frame.maxX)
                    attributes.frame.origin.x =  self.collectionView!.frame.maxX - delegate.collectionView(collectionView: collectionView!, widthForItemAtIndexPath: attributes.indexPath) // take the collection view max X minus the the item width
                    
                    collectionView?.translatesAutoresizingMaskIntoConstraints = false
                }
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
    
    
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
}
