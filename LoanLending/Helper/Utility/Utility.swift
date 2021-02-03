//
//  Utility.swift
//  Club11
//
//  Created by Developer on 17/05/19.
//  Copyright © 2019 Rickey_iDev. All rights reserved.
//

import UIKit

class Utility: NSObject {
    class func findCenterCellIndex(collectionView: UICollectionView) -> Int {
        var closestCell: UICollectionViewCell = collectionView.visibleCells[0]
        for cell in collectionView.visibleCells as [UICollectionViewCell] {
            let closestCellDelta = abs(closestCell.center.x - collectionView.bounds.size.width / 2.0 - collectionView.contentOffset.x)
            let cellDelta = abs(cell.center.x - collectionView.bounds.size.width / 2.0 - collectionView.contentOffset.x)
            if cellDelta < closestCellDelta {
                closestCell = cell
            }
        }
        let indexPath = collectionView.indexPath(for: closestCell)
        let visibleCellIndex = indexPath!.item
        print("The visible cell index is \(visibleCellIndex)")
        return visibleCellIndex
    }
    
    class func getStringFrom(seconds: Int) -> String {
        return seconds < 10 ? "0\(seconds)" : "\(seconds)"
    }
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    func createBodyWithParameters(parameters: [String: Any]?, filePathKey: String?, imageData: NSData!,imageName : String?, boundary: String) -> NSData {
        
        let body = NSMutableData()
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: String.Encoding.utf8)!)
                body.append("\(value)\r\n".data(using: String.Encoding.utf8)!)
            }
        }
        if (imageData != nil) {
            let mimetype = "image/jpg"
            
            body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(imageName! as String)\"\r\n".data(using: String.Encoding.utf8)!)
            body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: String.Encoding.utf8)!)
            body.append(imageData as Data)
            body.append("\r\n".data(using: String.Encoding.utf8)!)
            
        }
        
        body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)
        return body
    }
}
