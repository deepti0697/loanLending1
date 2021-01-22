//
//  HomeTCCell.swift
//  LoanLending
//
//  Created by deepti on 21/01/21.
//

import UIKit
protocol hitCollectionApi {
    func sendid(str:String)
}
class HomeTCCell: UITableViewCell {
    @IBOutlet weak var collctionView: UICollectionView!
    var delegat:hitCollectionApi?
    override func awakeFromNib() {
        super.awakeFromNib()
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.itemSize = CGSize(width: self.frame.width/4, height: self.frame.width/4)
              collectionLayout.minimumInteritemSpacing = 1
        collectionLayout.scrollDirection = .horizontal
        collctionView.collectionViewLayout = collectionLayout
        // Initialization code
    }
    var homeLoanArray = [LoanType]() {
        didSet {
            collctionView.reloadData()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension HomeTCCell:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeLoanArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeVCCollectionViewCell", for: indexPath) as! HomeVCCollectionViewCell
        cell.configureCell(response: homeLoanArray[indexPath.row])
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegat?.sendid(str: self.homeLoanArray[indexPath.row].id)
    }
}
