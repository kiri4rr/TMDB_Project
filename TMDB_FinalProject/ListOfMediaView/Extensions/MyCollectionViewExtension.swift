//
//  MyCollectionViewExtension.swift
//  TMDB
//
//  Created by Kirill Romanenko on 02.01.2023.
//

import UIKit
import SDWebImage

extension MyCollectionView: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isFiltering {
            myDelegate?.presentDetailView(arrayOfFilteredMedia[indexPath.row].name)
        }else {
            myDelegate?.presentDetailView(arrayOfMedia[indexPath.row].name)
        }
    }
}

extension MyCollectionView: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard isFiltering else { return arrayOfMedia.count }
        return arrayOfFilteredMedia.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.reuseID, for: indexPath) as! MyCollectionViewCell
        guard isFiltering else {
            let URLStr: String = Constants.singelton.getURLForPictureWeight200(arrayOfMedia[indexPath.row].URLStringOfMedia)
            cell.myLabel.text = arrayOfMedia[indexPath.row].name
            cell.mainImageView.sd_setImage(with: URL(string: URLStr), completed: nil)
            return cell
        }
        let URLStr: String = Constants.singelton.getURLForPictureWeight200( arrayOfFilteredMedia[indexPath.row].URLStringOfMedia)
        cell.myLabel.text = arrayOfFilteredMedia[indexPath.row].name
        cell.mainImageView.sd_setImage(with: URL(string: URLStr), completed: nil)
        return cell
    }
}

extension MyCollectionView: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/2 - 15, height: 250)
    }
}
