import UIKit
import SnapKit

final class MenuVC: UIViewController {
    // MARK: - Properties
    private var presenter: IMenuPresenter
    private let menuView = MenuView()

    // MARK: - Lifecycle
    init(presenter: IMenuPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 250/255, green: 249/255, blue: 249/255, alpha: 1)
        setupNavigation()
        layoutChildSubview()
        presenter.fetchMenuForShop()
        presenter.viewDidLoad(view: self)
        menuView.delegate = self
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

    @objc func dismissView() {
        presenter.dismissView()
    }

    private func layoutChildSubview() {
        view.addSubview(menuView)
        menuView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}


// MARK: - Presenter Output
extension MenuVC: IMenuView {
    
    func showAlert() {
        let alertController = UIAlertController(title: "Пусто", message: "Пожалуйста, вначале добавьте заказ :)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Отмена", style: .cancel)
        alertController.addAction(action)
        self.navigationController?.present(alertController, animated: true)
    }
    
    func updateData(data: [MenuItemModel]) {
        menuView.updateDataForCollectionView(data: data)
    }
}


// MARK: - Payment menu view delegate
extension MenuVC: IPayMenuInteraction {
    func goToPayment() {
        presenter.goToPayment()
    }
    
    func addToCart(item: OrderModel) {
        presenter.addToCart(item: item)
    }
    
    func removeFromCart(item: OrderModel) {
        presenter.removeFromCart(item: item)
    }

}
