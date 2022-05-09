
import Foundation
import UIKit

protocol Loadable {
    func showLoadingView()
    func hideLoadingView()
}

final class LoadingView: UIView {
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIActivityIndicatorView(style: .medium))
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = UIColor.black.withAlphaComponent(0.2)
        
        if activityIndicatorView.superview == nil {
            addSubview(activityIndicatorView)
            
            activityIndicatorView.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
            activityIndicatorView.startAnimating()
        }
    }
}

private enum Constants {
    fileprivate static let loadingViewTag = 2_501
}

extension Loadable where Self: UIViewController {
    
    func showLoadingView() {
        let loadingView = LoadingView()
        view.addSubview(loadingView)
        
        loadingView.snp.makeConstraints { make in
            make.height.equalTo(view.snp.height)
            make.width.equalTo(view.snp.width)
            make.center.equalTo(view.snp.center)
        }
        
        loadingView.tag = Constants.loadingViewTag
    }
    
    func hideLoadingView() {
        view.subviews.forEach { subview in
            if subview.tag == Constants.loadingViewTag {
                subview.removeFromSuperview()
            }
        }
    }
}
