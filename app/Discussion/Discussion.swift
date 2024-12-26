import Foundation

struct Discussion: Codable, Identifiable, Hashable {
    let id: Int
    let userName: String?
    let title: String
    let content: String
    let tag: String

    enum CodingKeys: String, CodingKey {
        case userName = "user_name"
        case id = "user_id"
        case title, content, tag
    }
}
