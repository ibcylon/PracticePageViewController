//
//  Pro.swift
//  PageViewQuestion
//
//  Created by Bridge MacStudio on 2022/11/10.
//

import Foundation

// TODO: Domain 으로 옮기기
public struct Pro: Codable {
  var pages: [ProConstant.ProTabPage]
  var feed: Feeds
  var subscribe: Subscribes
  var nickName: String
  
  static func dummy() -> Pro {
    Pro(pages: [.feed, .subscribe], feed: Feed.dummy(), subscribe: Subscribe.dummy(), nickName: "더미_테스트")
  }
}
