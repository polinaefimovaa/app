//
//  Post.swift
//  app
//
//  Created by Полина Ефимова on 19.12.24.
//

struct Post: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    let content: String?
    let tags: String
    let createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, content, tags
        case createdAt = "created_at"
    }
}
