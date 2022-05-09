
import Foundation
import Alamofire

protocol ArticlesPresenterProtocol: AnyObject {
    func getArticles(completion: @escaping (ArticleEntity?) -> Void)
}

class ArticlesPresenter {
    var router: ArticlesRouterProtocol?
    var interactor: ArticlesInteractorProtocol?
    var view: ArticlesViewProtocol?
}

extension ArticlesPresenter: ArticlesPresenterProtocol {
    func getArticles(completion: @escaping (ArticleEntity?) -> Void) {
        interactor?.getArticles(completion: { data, error in
            if let error = error {
                print(error)
                self.view?.showError(message: error.localizedDescription)
            }
            
            completion(data)
        })
    }
}
