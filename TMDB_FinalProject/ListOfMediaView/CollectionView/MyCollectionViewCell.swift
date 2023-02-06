//
//  MyCollectionViewCell.swift
//  TMDB
//
//  Created by Kirill Romanenko on 02.01.2023.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "CollectionViewCell"
    
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .brown
        return imageView
    }()
    
    let myLabel: UILabel = {
        let label = UILabel()
        label.frame.size.height = CGFloat(20)
        label.backgroundColor = .white
        label.font = UIFont(name: "System", size: 20)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(mainImageView)
        addSubview(myLabel)
        setupSettingsOfCell()
        setupConstraintOfMainImageView()
        setupConstraintOfMyLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Setup Constraint of Cell
    
    private func setupSettingsOfCell(){
        layer.cornerRadius = 7
        layer.masksToBounds = true
    }
    
    // MARK:- Setup Constraint of MainImageView
    
    private func setupConstraintOfMainImageView(){
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                   constant: 0),
            mainImageView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                    constant: 0),
            mainImageView.topAnchor.constraint(equalTo: topAnchor,
                                               constant: 0),
            mainImageView.bottomAnchor.constraint(equalTo: bottomAnchor,
                                               constant: 0)
        ])
    }
    
    // MARK:- Setup Constraint of Label
    
    private func setupConstraintOfMyLabel(){
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                   constant: 0),
            myLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                    constant: 0),
            myLabel.bottomAnchor.constraint(equalTo: bottomAnchor,
                                         constant: 0)
        ])
    }

    
}
