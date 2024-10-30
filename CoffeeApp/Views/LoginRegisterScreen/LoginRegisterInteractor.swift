import Alamofire
import Foundation
import KeychainAccess
import LocalAuthentication

protocol ILoginInteractor: AnyObject {
    func sendRegisterRequest(login: Login)
    func checkKeyChain()
    func validateText(text: String, field: TextFields)
    func sendAuthRequest(login: Login)
    init(dataSource: IDataSourceService, validationService: IValidatorService)
}

protocol ILoginInteractorOutput: AnyObject {
    func goToCoffeeShops(request: User)
    func showErrorAlert(error: Error)
    func showRegisterScreen()
    func showLoginScreen()
    func showRedBorder(field: TextFields, errorText: String)
    func showGreenBorder(field: TextFields)
}

final class LoginRegisterInteractor: ILoginInteractor {

    // MARK: - Properties
    weak var interactorOutput: ILoginInteractorOutput?
    private let dataSource: IDataSourceService
    private let validatorService: IValidatorService

    // MARK: - Lifecycle
    init( dataSource: IDataSourceService, validationService validatorService: IValidatorService) {
        self.dataSource = dataSource
        self.validatorService = validatorService
    }

    // MARK: - Functions
    func sendRegisterRequest(login: Login) {
        let headers: HTTPHeaders = [
            "Content-Type" : "application/json",
        ]
        let urlString = "http://147.78.66.203:3210/auth/register"
        AF.request(urlString,
                   method: .post,
                   parameters: login,
                   encoder: .json,
                   headers: headers).response { [weak self] response in
            self?.dataSource.getUser(response.data, completion: { [weak self] user in
                switch user {
                case .success(let newUser):
                    let keychain = Keychain()
                    do {
                        try keychain.set(login.login, key: "email")
                        try keychain.set(login.password, key: "password")
                        UserDefaults.standard.set("registered", forKey: "registered")
                        self?.interactorOutput?.goToCoffeeShops(request: newUser)
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let failure):
                    self?.interactorOutput?.showErrorAlert(error: failure)
                }
            })
        }
    }

    func sendAuthRequest(login: Login) {
        print("Login: \(login)")
        let headers: HTTPHeaders = [
            "Content-Type" : "application/json",
        ]
        let urlString = "http://147.78.66.203:3210/auth/login"
        AF.request(urlString,
                   method: .post,
                   parameters: login,
                   encoder: .json,
                   headers: headers).response { [weak self] response in
            self?.dataSource.getUser(response.data, completion: { [weak self] user in
                switch user {
                case .success(let newUser):
                    self?.interactorOutput?.goToCoffeeShops(request: newUser)
                case .failure(let failure):
                    self?.interactorOutput?.showErrorAlert(error: failure)
                }
            })
        }
    }

    func checkKeyChain() {
        let context = LAContext()
        var error: NSError?

        if let _ = UserDefaults.standard.string(forKey: "registered") {
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Authenticate to access your account."

                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, authenticationError in
                    DispatchQueue.main.async {
                        if success {
                            if let password = try? Keychain().get("password"), let email = try? Keychain().get("email") {
                                DispatchQueue.main.async {
                                    self?.interactorOutput?.showLoginScreen()
                                }
                                let login = Login(login: email, password: password)
                                self?.sendAuthRequest(login: login)
                            } else {
                                self?.interactorOutput?.showLoginScreen()
                            }
                        } else {
                            self?.interactorOutput?.showLoginScreen()
                            print("Authentication failed: \(authenticationError?.localizedDescription ?? "Unknown error")")
                        }
                    }
                }
            } else {
                interactorOutput?.showLoginScreen()
                print("Face ID is not available: \(error?.localizedDescription ?? "Unknown error")")
            }
        } else {
            interactorOutput?.showRegisterScreen()
        }
    }

    func validateText(text: String, field: TextFields) {
        validatorService.validateField(text: text, textFields: field) { result in
            switch result {
            case .success(_):
                interactorOutput?.showGreenBorder(field: field)
            case .failure(let failure):
                switch failure {
                case .emptyField:
                    interactorOutput?.showRedBorder(field: field, errorText: "Пустое поле")
                case .invalidEmail:
                    interactorOutput?.showRedBorder(field: field, errorText: "Неправильный email")
                case .invalidPassword:
                    interactorOutput?.showRedBorder(field: field, errorText: "Неправильный пароль")
                case .invalidRepeatPassword:
                    interactorOutput?.showRedBorder(field: field, errorText: "Пароли не совпадают")
                }
            }
        }
    }

}
