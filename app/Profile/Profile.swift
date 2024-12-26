import Foundation

struct Profile: Codable, Identifiable, Hashable {
    let id: Int
    let userId: Int // Изменено на camelCase для согласованности
    let name: String
    let dateOfBirth: Date
    let faculty: String
    let country: String
    let languages: String
    let programType: String
    let gender: String
    let createdAt: String?
    let updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case id, name, faculty, country, languages, gender
        case programType = "program_type"
        case dateOfBirth = "date_of_birth"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
