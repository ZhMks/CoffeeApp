import SnapKit
import Alamofire
import UIKit

final class LoginRegisterVC: UIViewController {

    // MARK: - Properties

    private var presenter: ILoginRegisterPresenter

    private let loginRegisterView = LoginRegisterScreen()

    // MARK: - Lifecycle
    init(presenter: ILoginRegisterPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 250/255, green: 249/255, blue: 249/255, alpha: 1)
        presenter.viewDidLoad(view: self)
        checkKeychain()
        layoutLoginView()
        presenter.sendRegistrationRequest(login: Login(login: "", password: ""))
        loginRegisterView.delegate = self
    }


    // MARK: - Functions

    private func layoutLoginView() {
        view.addSubview(loginRegisterView)
        loginRegisterView.translatesAutoresizingMaskIntoConstraints = false
        loginRegisterView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }

    private func changeNavTitle(title: String) {
        let navigationView = UIView()
        let titleLabel = UILabel()
        let title = title
        let characterSpacing = 0.12
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
        self.navigationItem.titleView = navigationView
    }

    private func checkKeychain() {
        let keychain = true
        if keychain {
            changeNavTitle(title: "Вход")
        } else {
            changeNavTitle(title: "Регистрация")
        }
        loginRegisterView.checkKeychain(keychain: keychain)
    }
}

// MARK: - Presenter Output
extension LoginRegisterVC: IMainScreenView {

}

// MARK: - IBUttonDelegate
extension LoginRegisterVC: IButtonTapped {
    func loginButtonTapped() {
        presenter.pushCoffeeShops()
    }
}
