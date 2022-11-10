//
//  Subscribe.swift
//  PageViewQuestion
//
//  Created by Bridge MacStudio on 2022/11/10.
//

import Foundation

typealias Subscribes = [Subscribe]

public struct Subscribe: Codable {
  var id: String
  var name: String
  var price: Int
  
  static func dummy() -> Subscribes {
    
    (1...10).map { number in
      let name = "구독\(number)"
      let price = number * 9
      
      return Subscribe(id: UUID().uuidString, name: name, price: price)
    }
  }
}
