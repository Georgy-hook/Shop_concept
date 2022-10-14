//
//  CarouselCell.swift
//  Ecomercie concept
//
//  Created by Georgy on 31.08.2022.
//

import UIKit

class CarouselCell: UICollectionViewCell {
    @IBOutlet weak var BackgroundImage: UIImageView!
    @IBOutlet weak var Label1: UILabel!
    
    @IBOutlet weak var ChekNewImage: UIImageView!

    @IBOutlet weak var Label2: UILabel!
    
    var image: UIImage?
    func update(image: UIImage) {
          BackgroundImage.image = image
      }
    
   
}
