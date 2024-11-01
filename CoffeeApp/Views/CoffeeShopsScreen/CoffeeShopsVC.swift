import UIKit
import SnapKit


final class CoffeeShopsVC: UIViewController {

    // MARK: - Properties
    private let coffeeShopView = CoffeeShopsView(frame: .zero)
    private let presenter: CoffeeShopsPresenter


    // MARK: - Lifecycle
    init(presenter: CoffeeShopsPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }


    // MARK: - Functions
    private func setupSubviews() {
        view.addSubview(coffeeShopView)
    }

    private func setupLayoutForSubviews() {
        coffeeShopView.translatesAutoresizingMaskIntoConstraints = false
        coffeeShopView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.snp.bottom)
            make.width.equalTo(view.snp.width)
        }
    }

    private func initialSetup() {
        view.backgroundColor = UIColor(red: 250/255, green: 249/255, blue: 249/255, alpha: 1)
        presenter.viewDidLoad(view: self)
        setupSubviews()
        setupLayoutForSubviews()
        presenter.fetchCoffeeShops()
        setupNavigationBar()
        coffeeShopView.delegate = self
    }

    private func setupNavigationBar() {
        let navigationView = UIView()
        let titleLabel = UILabel()
        let title = "Ближайшие кофейни"
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
        leftButton.setBackgroundImage(UIImage(named: "chevron.left"), for: .normal)
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

// MARK: -Presenter Output
extension CoffeeShopsVC: ICoffeeShopsView {

    func updateTableViewWithData(data: [CoffeeShopsModel]) {
        coffeeShopView.updateTableView(data: data)
    }
    
    func showError(error: any Error) {
        print(error.localizedDescription)
    }
    

}

// MARK: - CoffeShop Selected Delegate
extension CoffeeShopsVC: ICoffeeShopSelected {
    
    func didSelectCoffeeShop(_ coffeeShop: Int) {
        presenter.goToMenuView(id: coffeeShop)
    }

}


