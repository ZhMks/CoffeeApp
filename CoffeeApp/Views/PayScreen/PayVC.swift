import SnapKit
import UIKit



final class PayVC: UIViewController {

    // MARK: - Properties
    private let presenter: IPayPresenter
    private let payView = PayView()


    // MARK: - Lifecycle
    init(presenter: IPayPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    // MARK: - Functions
    private func setupNavigation() {
        let navigationView = UIView()
        let titleLabel = UILabel()
        let title = "Меню"
        let characterSpacing = -0.12
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 18),
            .foregroundColor: UIColor.systemBrown,
            .kern: characterSpacing
        ]

        let attributedTitle = NSMutableAttributedString(string: title, attributes: attributes)

        titleLabel.attributedText = attributedTitle
        titleLabel.sizeToFit()
        titleLabel.center = navigationView.center
        navigationView.addSubview(titleLabel)

        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 24))
        let leftButton = UIButton(frame: CGRect(x: 6, y: 6, width: 8, height: 12))
        leftButton.setBackgroundImage(UIImage(systemName: "chevron.left"), for: .normal)
        leftView.addSubview(leftButton)
        leftButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        leftButton.tintColor = .systemBrown

        let leftBarButton = UIBarButtonItem(customView: leftView)
        self.navigationItem.leftBarButtonItem = leftBarButton
        self.navigationItem.titleView = navigationView
    }

   @objc private func dismissView() {
       presenter.dismissView()
    }
}


// MARK: - Presenter output
extension PayVC: IPayView {


}
