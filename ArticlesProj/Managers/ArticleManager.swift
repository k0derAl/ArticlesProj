
import Foundation
import Alamofire

protocol ArticleManagerProtocol: AnyObject {
    func getArticles(completion: @escaping (ArticleEntity?, AFError?) -> Void)
}

class ArticleManager {
    private enum Urls {
        static let baseUrl = "https://api.jsonbin.io"
        static let articleEndUrl = "/b/620ca6bc1b38ee4b33bd9656"
    }
}

extension ArticleManager: ArticleManagerProtocol {
    func getArticles(completion: @escaping (ArticleEntity?, AFError?) -> Void) {
        let url = Urls.baseUrl + Urls.articleEndUrl
        AF.request(url).responseDecodable(of: ArticleEntity.self) { response in
            switch response.result {
            case .success(let data):
                completion(data, nil)
                
            case .failure(let error):
                print(error)
                if let url = R.file.articleStaticEntityJson() {
                    AF.request(url).responseDecodable(of: ArticleEntity.self) { response in
                        completion(response.value, error)
                    }
                }
            }
        }
    }
}
