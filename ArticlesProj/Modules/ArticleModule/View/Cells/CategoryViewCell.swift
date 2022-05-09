

import UIKit

class CategoryViewCell: UITableViewCell {
    private lazy var titleCategory: UILabel = {
        $0.font = .systemFont(ofSize: 24, weight: .bold)
        $0.textColor = .black
        return $0
    }(UILabel())
    
    private var collectionView: UICollectionView!
    private var selectedArticlIds: [String] = []
    private var dataSource: [ArticleEntityItem]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureTitleCategory()
        configureCollectionView()
    }
    
    public func setSection(_ data: ArticleEntitySection) {
        titleCategory.text = data.header
        dataSource = data.items
    }
    
    fileprivate func configureCollectionView() {
        let width: CGFloat = 80
        let height: CGFloat = 100
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: width, height: height)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(ArticleViewCell.self, forCellWithReuseIdentifier: String(describing: ArticleViewCell.self))
        
        contentView.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(titleCategory.snp.bottom).offset(10)
            make.height.equalTo(110)
            make.bottom.equalToSuperview().offset(-10)
        }
        
    }
    
    fileprivate func configureTitleCategory() {
        contentView.addSubview(titleCategory)
        titleCategory.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CategoryViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ArticleViewCell.self), for: indexPath) as? ArticleViewCell {
            if let dataSource = dataSource {
                let item = dataSource[indexPath.row]
                let isSelected = selectedArticlIds.contains(item.id)
                cell.setItemData(item, isSelected)
            }
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let dataSource = dataSource {
            let item = dataSource[indexPath.row]
            if selectedArticlIds.contains(item.id) {
                if let index = selectedArticlIds.firstIndex(of: item.id) {
                    selectedArticlIds.remove(at: index)
                }
            } else {
                if selectedArticlIds.count <= 6 {
                    selectedArticlIds.append(item.id)
                }
            }
            
            collectionView.reloadData()
        }
    }
    
}
