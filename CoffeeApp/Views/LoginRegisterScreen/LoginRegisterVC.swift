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
        setupView()
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

    private func setupView() {
        presenter.viewDidLoad(view: self)
        loginRegisterView.delegate = self
        layoutLoginView()
        view.backgroundColor = UIColor(red: 250/255, green: 249/255, blue: 249/255, alpha: 1)
        presenter.checkKeyChain()
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
}

// MARK: - Presenter Output
extension LoginRegisterVC: IMainScreenView {
    
    func showGreenBorderField(field: TextFields) {
        switch field {
        case .email:
            loginRegisterView.showGreenBorderForEmail()
        case .password:
            loginRegisterView.showGreenBorderForPassword()
        case .repeatPassword:
            loginRegisterView.showGreenBorderForRepeatPassword()
        }
    }
    
    func showRedBorderField(field: TextFields, errorText: String) {
        switch field {
        case .email:
            loginRegisterView.showRedBorderForEmailField(error: errorText)
        case .password:
            loginRegisterView.showRedBorderForPassword(error: errorText)
        case .repeatPassword:
            loginRegisterView.showRedBorderForRepeatPassword(error: errorText)
        }
    }
    

    func showViewLoginScreen() {
        changeNavTitle(title: "Вход")
        loginRegisterView.setUpForLoginView()
    }
    
    func showRegistrationScreen() {
        changeNavTitle(title: "Регистрация")
        loginRegisterView.setUpForRegisterView()
    }
    
    func showAlert(error: any Error) {
        let alertController = UIAlertController(title: "Ошибка", message: error.localizedDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: "Отмена", style: .cancel)
        alertController.addAction(action)
        navigationController?.present(alertController, animated: true)
    }
    

}

// MARK: - IBUttonDelegate
extension LoginRegisterVC: ILoginViewDelegate {

    func validationHappen(text: String, field: TextFields) {
        presenter.validateField(text: text, filed: field)
    }
    
    func loginButtonTapped(user: Login) {
        presenter.getUser(login: user)
    }
}
