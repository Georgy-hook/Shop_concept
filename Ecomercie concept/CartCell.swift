//
//  CartCell.swift
//  Ecomercie concept
//
//  Created by Georgy on 01.10.2022.
//

import UIKit

protocol MyCellDelegate {
    func didTapButtonInside(cell: CartCell)
}

class CartCell: UITableViewCell {
    
    var price:Int?
    var CountPhone = 1
    @IBOutlet weak var PhoneImage: UIImageView!
    @IBOutlet weak var DeleteButton: UIButton!
    @IBOutlet weak var CountPhoneField: UITextField!
    @IBOutlet weak var IncrementButton: UIButton!
    
    @IBOutlet weak var Price: UILabel!
    
    @IBOutlet weak var DecrementButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        CountPhoneField.text = String(CountPhone)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

    @IBAction func Increment(_ sender: Any) {
        CountPhone+=1
        Price.text = String(price! * CountPhone)
        CountPhoneField.text = String(CountPhone)
        
    }
    
    @IBAction func Decrement(_ sender: Any) {
        if CountPhone>1{
            CountPhone-=1
            Price.text = String(price! * CountPhone)
            CountPhoneField.text = String(CountPhone)
        }
    }
    
}
