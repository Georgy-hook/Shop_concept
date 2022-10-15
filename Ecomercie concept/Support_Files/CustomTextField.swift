//
//  CustomTextField.swift
//  Ecomercie concept
//
//  Created by Georgy on 11.01.2023.
//

import UIKit

class CustomTextField: UITextField {
    
 
    
    override func draw(_ rect: CGRect) {
        let findTextFieldImageView = UIImageView(frame: CGRect(x: 8.0, y: 12.0, width: 20.0, height: 20.0))
        let image = UIImage(named: "Search_Icon.png")
        findTextFieldImageView.image = image
        findTextFieldImageView.contentMode = .scaleAspectFit
        findTextFieldImageView.tintColor = .gray
        findTextFieldImageView.backgroundColor = .clear
        let findTextFieldView = UIView(frame: CGRect(x: 0, y: 0, width: 38, height: 40))
        findTextFieldView.addSubview(findTextFieldImageView)
        findTextFieldView.backgroundColor = .clear
        self.leftViewMode = UITextField.ViewMode.always
        self.leftView = findTextFieldView
    }

}
