
import UIKit
import SnapKit

protocol ArticlesViewProtocol: AnyObject {
    func showError(message: String)
}

class ArticlesViewController: UIViewController, Loadable {
    private lazy var tablewView: UITableView = {
        $0.delegate = self
        $0.dataSource = self
        $0.allowsSelection = false
        $0.separatorStyle = .none
        $0.register(CategoryViewCell.self, forCellReuseIdentifier: String(describing: CategoryViewCell.self))
        return $0
    }(UITableView())
    
    public var presenter: ArticlesPresenterProtocol?
    
    private var dataSource: ArticleEntity? {
        didSet {
            tablewView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        showLoadingView()
        presenter?.getArticles(completion: { data in
            self.dataSource = data
            self.hideLoadingView()
        })
    }
    
    fileprivate func configureTableView() {
        view.addSubview(tablewView)
        
        tablewView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
    }
}

extension ArticlesViewController: ArticlesViewProtocol {
    func showError(message: String) {
        self.hideLoadingView()
        let alert = UIAlertController(title: "Fail", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alert, animated: true)
    }
}

extension ArticlesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.sections.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CategoryViewCell.self), for: indexPath) as? CategoryViewCell {
            if let dataSource = dataSource {
                cell.setSection(dataSource.sections[indexPath.row])
            }
           
            return cell
        }
        return UITableViewCell()
    }
}
