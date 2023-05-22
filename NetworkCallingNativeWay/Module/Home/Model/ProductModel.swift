//
//  ProductModel.swift
//  NetworkCallingNativeWay
//
//  Created by Shivanshu Verma on 21/05/23.
//

import Foundation

struct ProductModel: Codable {
    var id: Int?
    var title: String?
    var price: Double?
    var description : String?
   // var category: Category?
    var image: URL?
    var rating: Rating?
}
enum Category: Codable {
    case electronics
    case jewellery
    case menClothing
    case womenClothing
}
struct Rating: Codable {
    var rate: Double?
    var count: Int?
}
/// #2
struct Demo: Codable {
    var status: Bool = false
    var statusCode: Int?
    var message: String?
    var data: [Onboarding]?
}
struct Onboarding: Codable {
    var imageDisplayName: String?
    var imageName: String?
    var imagePath: String?
}
