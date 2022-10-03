//
//  NewsFeedResponse.swift
//  PecodeTestTask
//
//  Created by Pavlo Myroshnychenko on 30.09.2022.
//

import Foundation

struct NewsFeedResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [ArticleDetails]
}
