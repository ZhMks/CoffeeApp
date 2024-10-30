import Alamofire
import SnapKit
import UIKit


protocol ILoginViewDelegate: AnyObject {
    func loginButtonTapped(user: Login)
    func validationHappen(text: String, field: TextFields)
}

final class LoginRegisterScreen: UIView {

    // MARK: - Properties

    weak var delegate: ILoginViewDelegate?

    var login = Login(login: "", password: "")

    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "e-mail"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .systemBrown
        return label
    }()

    private lazy var emailErrorLabel: UILabel = {
        let errorLabel = UILabel()
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.text = ""
        errorLabel.font = .systemFont(ofSize: 12, weight: .regular)
        errorLabel.textColor = .red
        errorLabel.isHidden = true
        return errorLabel
    }()

    private lazy var passwordErrorLabel: UILabel = {
        let errorLabel = UILabel()
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.text = ""
        errorLabel.font = .systemFont(ofSize: 12, weight: .regular)
        errorLabel.textColor = .red
        errorLabel.isHidden = true
        return errorLabel
    }()

    private lazy var repeatPasswordErrorLabel: UILabel = {
        let errorLabel = UILabel()
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.text = ""
        errorLabel.font = .systemFont(ofSize: 12, weight: .regular)
        errorLabel.textColor = .red
        errorLabel.isHidden = true
        return errorLabel
    }()

    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = UIColor.systemBrown.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 24.5
        let placeholderView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: textField.frame.height))
        textField.leftView = placeholderView
        textField.leftViewMode = .always
        textField.placeholder = "example@example.ru"
        textField.delegate = self
        return textField
    }()

    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Пароль"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .systemBrown
        return label
    }()

    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Введите пароль"
        let placeholderView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: textField.frame.height))
        textField.leftView = placeholderView
        textField.leftViewMode = .always
        textField.layer.borderColor = UIColor.systemBrown.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 24.5
        textField.isSecureTextEntry = true
        textField.delegate = self
        return textField
    }()

    private lazy var repeatPassword: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Повторите пароль"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .systemBrown
        return label
    }()

    private lazy var repeatPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Повторите пароль"
        let placeholderView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: textField.frame.height))
        textField.leftView = placeholderView
        textField.leftViewMode = .always
        textField.layer.borderColor = UIColor.systemBrown.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 24.5
        textField.isSecureTextEntry = true
        textField.delegate = self
        return textField
    }()

    private lazy var loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        let titleString = NSMutableAttributedString(string: "Регистрация")
        let attributes: [NSAttributedString.Key : Any] = [
            .font: UIFont.boldSystemFont(ofSize: 18),
            .foregroundColor: UIColor.systemBackground,
            .kern: 0.14
        ]
        titleString.addAttributes(attributes, range: NSRange(location: 0, length: titleString.length))
        button.setAttributedTitle(titleString, for: .normal)
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 24.5
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle
    init() {
        super.init(frame: .zero)
        addTapGesture()
        self.backgroundColor = .systemBackground
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: - Functions

    @objc private func loginButtonTapped() {
        delegate?.loginButtonTapped(user: login)
    }

    @objc private func makeViewFirstResponder() {
        self.endEditing(true)
    }

    private func addTapGesture() {
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(makeViewFirstResponder))
        self.addGestureRecognizer(tapgesture)
    }


}

// MARK: - TextFieldDelegate
extension LoginRegisterScreen: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTextField {
            delegate?.validationHappen(text: textField.text!, field: .email)
        } else if textField == passwordTextField {
            delegate?.validationHappen(text: textField.text!, field: .password)
        } else if textField == repeatPasswordTextField {
            delegate?.validationHappen(text: textField.text!, field: .repeatPassword)
        }
    }
}

// MARK: -Layout
extension LoginRegisterScreen {

    func setUpForLoginView() {
        let titleString = NSMutableAttributedString(string: "Войти")
        let attributes: [NSAttributedString.Key : Any] = [
            .font: UIFont.boldSystemFont(ofSize: 18),
            .foregroundColor: UIColor.systemBackground,
            .kern: 0.14
        ]
        titleString.addAttributes(attributes, range: NSRange(location: 0, length: titleString.length))
        loginRegisterButton.setAttributedTitle(titleString, for: .normal)
        addLoginSubviews()
        layoutConstraintsForLogin()
    }

    func setUpForRegisterView() {
        addRegisterSubviews()
        layoutConstraintsForRegister()
    }

    private func addLoginSubviews() {
        self.addSubview(emailLabel)
        self.addSubview(emailTextField)
        self.addSubview(passwordLabel)
        self.addSubview(passwordTextField)
        self.addSubview(loginRegisterButton)
    }

    private func layoutConstraintsForLogin() {
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(190)
            make.leading.equalTo(self.snp.leading).offset(18)
            make.trailing.equalTo(self.snp.trailing).offset(-316)
            make.height.equalTo(18)
        }

        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(8)
            make.leading.equalTo(self.snp.leading).offset(17)
            make.trailing.equalTo(self.snp.trailing).offset(-18)
            make.height.equalTo(47)
        }

        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(25)
            make.leading.equalTo(self.snp.leading).offset(18)
            make.trailing.equalTo(self.snp.trailing).offset(-306)
            make.height.equalTo(18)
        }

        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(8)
            make.leading.equalTo(self.snp.leading).offset(17)
            make.trailing.equalTo(self.snp.trailing).offset(-18)
            make.height.equalTo(47)
        }

        loginRegisterButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.leading.equalTo(self.snp.leading).offset(17)
            make.trailing.equalTo(self.snp.trailing).offset(-18)
            make.height.equalTo(47)
        }
    }

    private func addRegisterSubviews() {
        self.addSubview(emailLabel)
        self.addSubview(emailTextField)
        self.addSubview(passwordLabel)
        self.addSubview(passwordTextField)
        self.addSubview(repeatPassword)
        self.addSubview(repeatPasswordTextField)
        self.addSubview(loginRegisterButton)
    }

    private func layoutConstraintsForRegister() {
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(190)
            make.leading.equalTo(self.snp.leading).offset(18)
            make.trailing.equalTo(self.snp.trailing).offset(-316)
            make.height.equalTo(18)
        }

        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(8)
            make.leading.equalTo(self.snp.leading).offset(17)
            make.trailing.equalTo(self.snp.trailing).offset(-18)
            make.height.equalTo(47)
        }

        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(25)
            make.leading.equalTo(self.snp.leading).offset(18)
            make.trailing.equalTo(self.snp.trailing).offset(-306)
            make.height.equalTo(18)
        }

        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(8)
            make.leading.equalTo(self.snp.leading).offset(17)
            make.trailing.equalTo(self.snp.trailing).offset(-18)
            make.height.equalTo(47)
        }

        repeatPassword.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(25)
            make.leading.equalTo(self.snp.leading).offset(18)
            make.trailing.equalTo(self.snp.trailing).offset(-232)
            make.height.equalTo(18)
        }

        repeatPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(repeatPassword.snp.bottom).offset(8)
            make.leading.equalTo(self.snp.leading).offset(17)
            make.trailing.equalTo(self.snp.trailing).offset(-18)
            make.height.equalTo(47)
        }

        loginRegisterButton.snp.makeConstraints { make in
            make.top.equalTo(repeatPasswordTextField.snp.bottom).offset(30)
            make.leading.equalTo(self.snp.leading).offset(17)
            make.trailing.equalTo(self.snp.trailing).offset(-18)
            make.height.equalTo(47)
        }
    }

    func showRedBorderForEmailField(error: String) {
        loginRegisterButton.isEnabled = false
        loginRegisterButton.backgroundColor = .systemGray5
        emailErrorLabel.isHidden = false
        emailErrorLabel.text = error
        addSubview(emailErrorLabel)
        emailTextField.layer.borderColor = UIColor.red.cgColor

        emailLabel.snp.remakeConstraints { make in
            make.top.equalTo(self.snp.top).offset(160)
            make.leading.equalTo(self.snp.leading).offset(18)
            make.trailing.equalTo(self.snp.trailing).offset(-316)
            make.height.equalTo(18)
        }
        emailTextField.snp.remakeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.snp.leading).offset(18)
            make.trailing.equalTo(self.snp.trailing).offset(-17)
            make.height.equalTo(47)
        }
        emailErrorLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(5)
            make.leading.equalTo(self.snp.leading).offset(18)
            make.trailing.equalTo(self.snp.trailing).offset(-10)
            make.height.equalTo(18)
        }
    }

    func showGreenBorderForEmail() {
        login.login = emailTextField.text!
        emailErrorLabel.removeFromSuperview()
        emailTextField.layer.borderColor = UIColor.green.cgColor

        emailLabel.snp.remakeConstraints { make in
            make.top.equalTo(self.snp.top).offset(190)
            make.leading.equalTo(self.snp.leading).offset(18)
            make.trailing.equalTo(self.snp.trailing).offset(-316)
            make.height.equalTo(18)
        }

        emailTextField.snp.remakeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(8)
            make.leading.equalTo(self.snp.leading).offset(17)
            make.trailing.equalTo(self.snp.trailing).offset(-18)
            make.height.equalTo(47)
        }
    }

    func showRedBorderForPassword(error: String) {
        loginRegisterButton.isEnabled = false
        loginRegisterButton.backgroundColor = .systemGray5
        passwordErrorLabel.isHidden = false
        passwordErrorLabel.text = error

        addSubview(passwordErrorLabel)

        passwordTextField.layer.borderColor = UIColor.red.cgColor

        passwordErrorLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(5)
            make.leading.equalTo(self.snp.leading).offset(17)
            make.trailing.equalTo(self.snp.trailing).offset(-18)
            make.height.equalTo(18)
        }

        repeatPassword.snp.remakeConstraints { make in
            make.top.equalTo(passwordErrorLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.snp.leading).offset(18)
            make.trailing.equalTo(self.snp.trailing).offset(-232)
            make.height.equalTo(18)
        }

        repeatPasswordTextField.snp.remakeConstraints { make in
            make.top.equalTo(repeatPassword.snp.bottom).offset(8)
            make.leading.equalTo(self.snp.leading).offset(17)
            make.trailing.equalTo(self.snp.trailing).offset(-18)
            make.height.equalTo(47)
        }

    }

    func showGreenBorderForPassword() {
        passwordErrorLabel.removeFromSuperview()
        passwordTextField.layer.borderColor = UIColor.green.cgColor

        repeatPassword.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(25)
            make.leading.equalTo(self.snp.leading).offset(18)
            make.trailing.equalTo(self.snp.trailing).offset(-232)
            make.height.equalTo(18)
        }

        repeatPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(repeatPassword.snp.bottom).offset(8)
            make.leading.equalTo(self.snp.leading).offset(17)
            make.trailing.equalTo(self.snp.trailing).offset(-18)
            make.height.equalTo(47)
        }
    }

    func showRedBorderForRepeatPassword(error: String) {
        loginRegisterButton.isEnabled = false
        repeatPasswordErrorLabel.isHidden = false
        loginRegisterButton.backgroundColor = .systemGray5
        addSubview(repeatPasswordErrorLabel)

        repeatPasswordErrorLabel.text = error

        repeatPasswordTextField.layer.borderColor = UIColor.red.cgColor

        repeatPasswordErrorLabel.snp.makeConstraints { make in
            make.top.equalTo(repeatPasswordTextField.snp.bottom).offset(10)
            make.leading.equalTo(self.snp.leading).offset(18)
            make.trailing.equalTo(self.snp.trailing).offset(-18)
            make.height.equalTo(18)
        }
    }

    func showGreenBorderForRepeatPassword() {
        login.password = repeatPasswordTextField.text!
        repeatPasswordErrorLabel.removeFromSuperview()
        repeatPasswordTextField.layer.borderColor = UIColor.green.cgColor
        loginRegisterButton.isEnabled = true
        loginRegisterButton.backgroundColor = UIColor(red: 52/255, green: 25/255, blue: 26/255, alpha: 1)
    }
}
