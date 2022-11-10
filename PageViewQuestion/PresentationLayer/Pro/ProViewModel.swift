//
//  ProViewModel.swift
//  PageViewQuestion
//
//  Created by Bridge MacStudio on 2022/11/10.
//

import Foundation

struct ProViewModel {
  private let proService: ProService
  
  init(service: ProService) {
    self.proService = service
  }
  
  func loadProfile(id: String) async throws -> Pro {
    try await proService.fetch(id: id)
  }
}
