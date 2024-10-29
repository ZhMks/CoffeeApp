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
        presenter.viewDidLoad(view: loginRegisterView)
        changeNavTitle()
        layoutLoginView()
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

    private func changeNavTitle() {
        let navigationView = UIView()
        let titleLabel = UILabel()
        let title = "Регистрация"
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
