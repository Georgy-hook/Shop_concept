//
//  GroupCell.swift
//  Ecomercie concept
//
//  Created by Georgy on 17.09.2022.
//Функции отклика на лайк, а также аутлеты на составляющие

import UIKit

class GroupCell: UICollectionViewCell {
    @IBOutlet weak var LabelOldPrice: UILabel!
    
    @IBOutlet weak var LabelName: UILabel!
    @IBOutlet weak var LabelPrice: UILabel!
    @IBOutlet weak var BackgroundImage: UIImageView!
    var IsLike = false
    @IBAction func LikeMe(_ sender: UIButton) {
        if sender.currentImage == UIImage(systemName: "heart",withConfiguration: UIImage.SymbolConfiguration(scale: .small)) || sender.currentImage == UIImage(named: "heart"){
            sender.setImage(UIImage(systemName: "heart.fill", withConfiguration: UIImage.SymbolConfiguration(scale: .small)), for: .normal)
            IsLike = true
        }
        else{
            sender.setImage(UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(scale: .small)), for: .normal)
            IsLike = false
        }
        
    }
}
