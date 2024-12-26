import Foundation

struct PostImage: Codable, Hashable {
    let url: String
    let thumb: ImageDetails
    let q70: ImageDetails
    
    struct ImageDetails: Codable, Hashable {
        let url: String
    }
}

struct Article: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    let content: String?
    let tags: String
    let post_image: PostImage
    let createdAt: String?
    let updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "user_id"
        case title, content, tags
        case post_image
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
