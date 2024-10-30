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

        view.backgroundColor = .white

        presenter.viewDidLoad(view: self)
        
        setupSubviews()
        setupLayoutForSubviews()
        presenter.fetchCoffeeShops()
    }


    // MARK: - Functions
    private func setupSubviews() {
        view.addSubview(coffeeShopView)
    }

    private func setupLayoutForSubviews() {
        coffeeShopView.translatesAutoresizingMaskIntoConstraints = false
        coffeeShopView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.snp.width)
        }
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
