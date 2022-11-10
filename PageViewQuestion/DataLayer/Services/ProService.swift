//
//  ProService.swift
//  PageViewQuestion
//
//  Created by Bridge MacStudio on 2022/11/10.
//

import Foundation

public struct ProService {
  public init() { }
  
  public func fetch(id: String) async throws -> Pro {
    print("fetch...")
    try await Task.sleep(nanoseconds: .oneSecond)
    let pro = Pro.dummy()
    
    return pro
  }
}

extension UInt64 {
  static let oneSecond: UInt64 = 1_000_000_000
}
