//
//  MessageCollectionViewLayout.swift
//  TestUIConstraint
//
//  Created by Gavin Ong on 18/7/18.
//  Copyright © 2018 Gavin Ong. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

extension Int {
    var degreesToRadians: Double { return Double(self) * .pi / 180 }
}
extension CGFloat {
    var degreesToRadians: CGFloat { return self * .pi / 180 }
}

protocol MessageCollectionViewLayoutDelegate {
    func collectionView(collectionView: UICollectionView, heightForItemAtIndexPath indexPath: IndexPath) -> CGFloat
    
    func collectionView(collectionView:UICollectionView, widthForItemAtIndexPath indexPath: IndexPath) -> CGFloat
    
    func contentInsets() -> UIEdgeInsets
    
    
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
            return self.collectionView!.frame.width

        }
    }
    
    override var collectionViewContentSize: CGSize {
        guard let collectionView = collectionView else {
            preconditionFailure("collection view layout doesn't have a collection view!")
        }
        return collectionView.frame.size
    }
    
//    private var sectionInset: UIEdgeInsets
    
    
//    override var collectionViewContentSize: CGSize{
//        return CGSize(width: contentWidth, height: contentHeight)
//    }
//
//    override func prepare(){
//
//        let bounds = collectionView!.bounds
//        let O = CGPoint(x: bounds.midX, y: bounds.midY)
//
//        for section in 0..<collectionView!.numberOfSections{
//
//            let itemCount = collectionView!.numberOfItems(inSection: section)
//
//
//
//            let cgItemCount = CGFloat(itemCount)
//
//            for i in 0..<itemCount{
//
//                let x = O.x
//                let y = O.y
//                let frameOrigin = CGPoint(x: x + 10, y: y)
//
//                let cellFrame = CGRect(origin: frameOrigin, size: CGSize(width: 100, height: 100))
//
//
//                //append the cell attributes to the cache
//                let indexPath = IndexPath(item: i, section: section)
//
//                let layoutAttributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
//
//                layoutAttributes.frame = cellFrame
//
//
//                cache.append(layoutAttributes)
//
//
//
//
//
//            }
//
//
//
//        }
//
//
//    }
 //   var itemSpacingDegrees: CGFloat = 3.0
    
//    override func prepare() {
//        guard self.cache.isEmpty, let collectionView = self.collectionView else { return }
//        for section in 0..<collectionView.numberOfSections {
//            let itemCount = collectionView.numberOfItems(inSection: section)
//            let cgItemCount = CGFloat(itemCount)
//
//            for i in 0..<itemCount {
//                let bounds = collectionView.bounds
//                let O = CGPoint(x: bounds.midX, y: bounds.midY)
//                let R = bounds.width / 2.0
//                let radiansSoFar = CGFloat((i * 360/itemCount)).degreesToRadians
//                let endAngle = radiansSoFar + (360.0/cgItemCount - self.itemSpacingDegrees).degreesToRadians
//                let θ = (endAngle - radiansSoFar)
//                let r = (R * sin(θ/2.0)) / (sin(θ/2.0) + 1)
//                let OC = R - r
//                let x = cos(radiansSoFar + θ / 2.0) * OC - r + O.x
//                let y = sin(radiansSoFar + θ / 2.0) * OC - r + O.y
//                let frameOrigin = CGPoint(x: x, y: y)
//                let cellFrame = CGRect(origin: frameOrigin, size: CGSize(width: 2*r, height: 2*r))
//
//                let indexPath = IndexPath(item: i, section: section)
//                let layoutAttributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
//                layoutAttributes.frame = cellFrame
//                self.cache.append(layoutAttributes)
//            }
//        }
//    }
    
    
    override func invalidateLayout() {
        super.invalidateLayout()
        cache = []
    }

    

    
    override func prepare(){

         //let insets = self.delegate?.contentInsets() ?? UIEdgeInsets.zero

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

                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)

                if !delegate.isSender(indexPath: indexPath){

                    let height = delegate.collectionView(collectionView: collectionView!, heightForItemAtIndexPath: indexPath)

                    let width = delegate.collectionView(collectionView: collectionView!, widthForItemAtIndexPath: indexPath)

                    let frame = CGRect(x: xOffsets[column], y: yOffsets[column], width: width, height: height)

//                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)

                    // let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)

                    attributes.frame = frame

//                    attributes.frame = insetFrame

                    cache.append(attributes)

                    contentHeight = max(contentHeight, frame.maxY)

                    yOffsets[column] = yOffsets[column] + height

                    //xOffsets[column] = xOffsets[column] - width

                    column = column >= (numberOfColumns - 1) ? 0 : column + 1

                }else{

                    let height = delegate.collectionView(collectionView: collectionView!, heightForItemAtIndexPath: indexPath)

                    let width = delegate.collectionView(collectionView: collectionView!, widthForItemAtIndexPath: indexPath)
                    
                    let rightAlign = self.collectionView!.frame.maxX - width

                    let frame = CGRect(x: xOffsets[column] + rightAlign, y: yOffsets[column], width: width, height: height)

                    //                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)

                 //   let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)



                    attributes.frame = frame

                    //                attributes.frame = insetFrame

                    //attributes.frame.origin.x =  fra- delegate.collectionView(collectionView: collectionView!, widthForItemAtIndexPath: attributes.indexPath)

                    cache.append(attributes)

                    contentHeight = max(contentHeight, frame.maxY)

                    //xOffsets[column] = xOffsets[column] + 20

                    yOffsets[column] = yOffsets[column] + height



                    column = column >= (numberOfColumns - 1) ? 0 : column + 1

                }



            }


        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        //var layoutAttributes = [UICollectionViewLayoutAttributes]()

       // var leftMargin = self.collectionView.sectionInse
        
        
        let itemAttributes = cache.filter{
            $0.frame.intersects(rect)
        }
        
        
        return itemAttributes


//        for attributes in cache{
//            if attributes.frame.intersects(rect){
//
//                //attributes.frame.origin.x = delegate.contentInsets().left
//
//
////                if !delegate.isSender(indexPath: attributes.indexPath){
////                    attributes.frame.origin.x = 5
////
////                    collectionView?.translatesAutoresizingMaskIntoConstraints = false
////                }else{
////
////                    print(self.collectionView!.frame.maxX)
////                    attributes.frame.origin.x =  self.collectionView!.frame.maxX - delegate.collectionView(collectionView: collectionView!, widthForItemAtIndexPath: attributes.indexPath) // take the collection view max X minus the the item width
////
////                    collectionView?.translatesAutoresizingMaskIntoConstraints = false
////                }
//                layoutAttributes.append(attributes)
//            }
//        }
//        return layoutAttributes
    }
    
    
    
    

    
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache.first {
            $0.indexPath == indexPath
        }
    }
    
    
    
    
    
    
    
    
    
    
}
