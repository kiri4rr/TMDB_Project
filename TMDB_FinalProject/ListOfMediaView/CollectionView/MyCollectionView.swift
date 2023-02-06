//
//  MyCollectionView.swift
//  TMDB
//
//  Created by Kirill Romanenko on 02.01.2023.
//

import UIKit

class MyCollectionView: UICollectionView {
    
    var myDelegate: PresenterOfDetailView?
    var arrayOfMedia: Array<MediaModel> = Array<MediaModel>()
    var arrayOfFilteredMedia: Array<MediaModel> = Array<MediaModel>()
    var isFiltering = false

    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(frame: .zero, collectionViewLayout: layout)
        delegate = self
        dataSource = self
        setupSettingsForCollectionView()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSettingsForCollectionView(){
        register(MyCollectionViewCell.self,
                 forCellWithReuseIdentifier: MyCollectionViewCell.reuseID)
        translatesAutoresizingMaskIntoConstraints = false
        contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layer.masksToBounds = true
        backgroundColor = .white
    }

}
