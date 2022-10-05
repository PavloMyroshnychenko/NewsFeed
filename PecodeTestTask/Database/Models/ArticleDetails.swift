//
//  ArticleDetails.swift
//  PecodeTestTask
//
//  Created by Pavlo Myroshnychenko on 30.09.2022.
//

import Foundation
import RealmSwift

final class ArticleDetails: Object, Codable {
    @Persisted var source: ArticleSource?
    @Persisted var author: String?
    @Persisted var title: String?
    @Persisted var articleDescription: String?
    @Persisted(primaryKey: true) var url: String?
    @Persisted var urlToImage: String?
    @Persisted var publishedAt: String?
    @Persisted var content: String?
    
    required override init() { }
    
    enum CodingKeys: String, CodingKey {
        case source
        case author
        case title
        case articleDescription = "description"
        case url
        case urlToImage
        case publishedAt
        case content
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(source, forKey: .source)
        try container.encode(author, forKey: .author)
        try container.encode(title, forKey: .title)
        try container.encode(articleDescription, forKey: .articleDescription)
        try container.encode(url, forKey: .url)
        try container.encode(urlToImage, forKey: .urlToImage)
        try container.encode(publishedAt, forKey: .publishedAt)
        try container.encode(content, forKey: .content)
    }
    
    init(from decoder: Decoder) throws {
        super.init()
        let container = try! decoder.container(keyedBy: CodingKeys.self)
        source = try! container.decode(ArticleSource.self, forKey: .source)
        author = try! container.decodeIfPresent(String.self, forKey: .author)
        title = try! container.decode(String.self, forKey: .title)
        articleDescription = try! container.decodeIfPresent(String.self, forKey: .articleDescription)
        url = try! container.decode(String.self, forKey: .url)
        urlToImage = try! container.decodeIfPresent(String.self, forKey: .urlToImage)
        publishedAt = try! container.decode(String.self, forKey: .publishedAt)
        content = try! container.decodeIfPresent(String.self, forKey: .content)
    }
}
