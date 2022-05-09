
import Foundation

struct ArticleEntity: Codable {
    let sections: [ArticleEntitySection]
}

struct ArticleEntitySection: Codable {
    let id: String
    let header: String
    let items: [ArticleEntityItem]
}

struct ArticleEntityItem: Codable {
    let id: String
    let image: ArticleEntityImage
    let title: String
}

struct ArticleEntityImage: Codable {
    let x1: String
    let x2: String
    let x3: String
    
    enum CodingKeys: String, CodingKey {
        case x1 = "1x"
        case x2 = "2x"
        case x3 = "3x"
    }
}
