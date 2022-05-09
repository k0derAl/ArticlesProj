
import Foundation
import Alamofire

protocol ArticlesInteractorProtocol: AnyObject {
    func getArticles(completion: @escaping (ArticleEntity?, AFError?) -> Void)
}

class ArticlesInteractor {
    let articleManager: ArticleManagerProtocol
    
    init(articleManager: ArticleManagerProtocol) {
        self.articleManager = articleManager
    }
}

extension ArticlesInteractor: ArticlesInteractorProtocol {
    func getArticles(completion: @escaping (ArticleEntity?, AFError?) -> Void) {
        articleManager.getArticles(completion: completion)
    }
}
