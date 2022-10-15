//
//  Strikethrough:underline_Function.swift
//  Ecomercie concept
//
//  Created by Georgy on 04.01.2023.
// Функция для зачеркивания/подчеркивания текста
import Foundation
import UIKit

func MakeText(type:String) -> NSAttributedString{
    var attributedText: NSAttributedString?
    switch type{
    case "strikeThrough":
         attributedText = NSAttributedString(
        string: "Label Text",
        attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
        )
    case "underLine":
         attributedText = NSAttributedString(
            string: "Label Text",
            attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue,.underlineColor:UIColor(rgb:0xFF6E4E)]
            )
    case "underLineShop":
        attributedText = NSAttributedString(
           string: "Shop",
           attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue,.underlineColor:UIColor(rgb:0xFF6E4E),.font: UIFont(name: "Mark Pro Bold", size: 20)!,.foregroundColor:(UIColor(ciColor: .black))]
           )
    case "underLineDetails":
        attributedText = NSAttributedString(
           string: "Details",
           attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue,.underlineColor:UIColor(rgb:0xFF6E4E),.font: UIFont(name: "Mark Pro Bold", size: 20)!,.foregroundColor:(UIColor(ciColor: .black))]
           )
    case "underLineFeatures":
        attributedText = NSAttributedString(
           string: "Features",
           attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue,.underlineColor:UIColor(rgb:0xFF6E4E),.font: UIFont(name: "Mark Pro Bold", size: 20)!,.foregroundColor:(UIColor(ciColor: .black))]
           )
    case "DefaultLineShop":
        attributedText = NSAttributedString(
           string: "Shop",
           attributes: [.font: UIFont(name: "Mark Pro", size: 20)!,.foregroundColor:UIColor(rgb: 0x9A9A9A)]
           )
    case "DefaultDetails":
        attributedText = NSAttributedString(
           string: "Details",
           attributes: [.font: UIFont(name: "Mark Pro", size: 20)!,.foregroundColor:UIColor(rgb: 0x9A9A9A)]
           )
    case "DefaultFeatures":
        attributedText = NSAttributedString(
           string: "Features",
           attributes: [.font: UIFont(name: "Mark Pro", size: 20)!,.foregroundColor:UIColor(rgb: 0x9A9A9A)]
           )
    default:
        print("error atribbuted")
    }
    return attributedText!}
import Foundation
