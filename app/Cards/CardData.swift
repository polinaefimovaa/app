import SwiftUI

struct Card: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var description: String
    var tags: [String]
}
