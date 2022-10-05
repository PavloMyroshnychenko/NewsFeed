//
//  ArticleSource.swift
//  PecodeTestTask
//
//  Created by Pavlo Myroshnychenko on 30.09.2022.
//

import Foundation
import RealmSwift

final class ArticleSource: Object, Codable {
    @Persisted var id: String?
    @Persisted var name: String
    
    required override init() { }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
    }
    
    init(from decoder: Decoder) throws {
        let container = try! decoder.container(keyedBy: CodingKeys.self)
        id = try! container.decodeIfPresent(String.self, forKey: .id)
        name = try! container.decode(String.self, forKey: .name)
    }
}
