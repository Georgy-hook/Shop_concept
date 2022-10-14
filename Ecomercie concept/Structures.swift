//
//  Sections.swift
//  Ecomercie concept
//
//  Created by Georgy on 21.09.2022.
//

import Foundation
import UIKit
struct Sections{
    var Filter:String
    var FilterFill: [String]
    var Expanded: Bool
}
struct Response: Codable {
    let home_store: [jsonread]
    let best_seller: [jsonread2]
}
struct jsonread : Codable{
    var id: Int
//    var is_new: Bool
    var title: String
    var subtitle: String
    var picture: String
    var is_buy: Bool

  }
struct jsonread2 : Codable{
    var id: Int
    var is_favorites: Bool
    var title: String
    var price_without_discount: Int
    var discount_price: Int
    var picture: String

  }
struct Details:Codable{
    var CPU: String
    var camera: String
    var capacity: [String]
    var color: [String]
    var id: String
    var images: [String]
    var isFavorites: Bool
    var price: Int
    var rating: Double
    var sd: String
    var ssd: String
    var title: String
}


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
    
var Cart:Int! = 0
