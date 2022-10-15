//
//  Sections.swift
//  Ecomercie concept
//
//  Created by Georgy on 21.09.2022.
// Структуры для Codable-парсинга get запросов к API

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



    

