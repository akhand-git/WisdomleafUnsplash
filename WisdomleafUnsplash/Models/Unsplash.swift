//
//  Unsplash.swift
//  WisdomleafUnsplash
//
//  Created by Akhand on 11/09/20.
//  Copyright © 2020 Akhand. All rights reserved.
//

import Foundation

class Unsplash: Codable {
       let id: String?
       let author : String?
       let width : Int?
       let height : Int?
       let url : String?
       let download_url : String?
    
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case author = "author"
        case width = "width"
        case height = "height"
        case url = "url"
        case download_url = "download_url"
    }
    
    required init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        author = try values.decodeIfPresent(String.self, forKey: .author)
        width = try values.decodeIfPresent(Int.self, forKey: .width)
        height = try values.decodeIfPresent(Int.self, forKey: .height)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        download_url = try values.decodeIfPresent(String.self, forKey: .download_url)
        
    }
}
//struct Unsplash : Identifiable,Decodable {
//    var id: String
//    let author : String
//    let width : Int
//    let height : Int
//    let url : String
//    let download_url : String
//    let desc : String
//}
//
//extension Unsplash{
//    static var readAllUnsplash:[Unsplash] {
//        let url = Bundle.main.url(forResource: "unsplash", withExtension: "json")!
//        let data = try! Data(contentsOf: url)
//        let unsplash = try! JSONDecoder().decode([Unsplash].self, from: data)
//        return unsplash
//    }
//}
