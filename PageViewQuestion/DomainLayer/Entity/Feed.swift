//
//  Feed.swift
//  PageViewQuestion
//
//  Created by Bridge MacStudio on 2022/11/10.
//

import Foundation

typealias Feeds = [Feed]

public struct Feed: Codable {
  var id: String
  var title: String
  var content: String
  
  static func dummy() -> Feeds {
    
    (1...10).map { number in
      let title = "피드 \(number)"
      let content: String = (1...number).reduce("내용없음") { partialResult, _ in
        partialResult + "\n내용 없음"
      }
      
      return Feed(id: UUID().uuidString, title: title, content: content)
    }
  }
}
