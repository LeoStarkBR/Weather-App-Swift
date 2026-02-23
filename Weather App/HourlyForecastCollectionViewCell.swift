//
//  HourlyForecastCollectionViewCell.swift
//  Weather App
//
//  Created by Leonardo Gabriel Lopes Gimenes on 23/02/26.
//

import UIKit

class HourlyForecastCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect ){
        super.init(frame: frame)
        
        contentView.backgroundColor = .green
    }
    
    required init?(coder: NSCoder){
        fatalError("Init(Coder:) has not been implemented")
    }
}
