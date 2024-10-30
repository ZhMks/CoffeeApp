import Alamofire
import Foundation
import KeychainAccess

protocol ILoginInteractor: AnyObject {
    func sendRegisterRequest(login: Login)
    func checkKeyChain()
    func validateText(text: String, field: TextFields)
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
                        try keychain.set(login.password, key: login.login)
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

    func checkKeyChain() {
        if let token = try? Keychain().get("") {
            interactorOutput?.showLoginScreen()
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
