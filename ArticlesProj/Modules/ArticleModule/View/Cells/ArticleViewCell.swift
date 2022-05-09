
import UIKit
import Kingfisher

class ArticleViewCell: UICollectionViewCell {
    private lazy var backgroundImageView: UIImageView = {
        $0.layer.cornerRadius = 12
        $0.backgroundColor = .clear
        $0.layer.masksToBounds = true
        $0.layer.borderColor = UIColor.blue.cgColor
        return $0
    }(UIImageView())
    
    private let blurEffect = UIBlurEffect(style: .prominent)
    private lazy var blurEffectView: UIVisualEffectView = {
        return $0
    }(UIVisualEffectView(effect: blurEffect))
    
    private lazy var descrtiopLabel: UILabel = {
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 10, weight: .medium)
        return $0
    }(UILabel())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureBackgroundImageView()
        configureDescriptionLabel()
        configureBlurEffectView()
    }
    
    public func setItemData(_ data: ArticleEntityItem, _ isSelected: Bool) {
        if let urlImage = URL(string: data.image.x1) {
            backgroundImageView.kf.setImage(with: urlImage)
        }
        descrtiopLabel.text = data.title
        
        if isSelected {
            backgroundImageView.layer.borderWidth = 1
        } else {
            backgroundImageView.layer.borderWidth = 0
        }
    }
    
    fileprivate func configureDescriptionLabel() {
        backgroundImageView.addSubview(blurEffectView)
        backgroundImageView.addSubview(descrtiopLabel)
        
        descrtiopLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-5)
            make.left.right.equalToSuperview().inset(5)
        }
    }
    
    fileprivate func configureBlurEffectView() {
        
        blurEffectView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalTo(descrtiopLabel.snp.top)
        }
    }
   
    fileprivate func configureBackgroundImageView() {
        contentView.addSubview(backgroundImageView)
        
        backgroundImageView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
