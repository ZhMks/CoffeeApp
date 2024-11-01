
import Foundation
import Alamofire

protocol ILoginRegisterPresenter: AnyObject {
    init(router: IMainRouter, interactor: ILoginInteractor)
    func viewDidLoad(view: LoginRegisterVC)
    func sendRegistrationRequest(login: Login)
    func checkKeyChain()
    func validateField(text: String, filed: TextFields)
    func getUser(login: Login)
    func authUser(user: Login)
}

protocol IMainScreenView: AnyObject {
    func showAlert(error: Error)
    func showViewLoginScreen()
    func showRegistrationScreen()
    func showGreenBorderField(field: TextFields)
    func showRedBorderField(field: TextFields, errorText: String)
}

final class LoginRegisterPresenter: ILoginRegisterPresenter {

    // MARK: - Properties
    private let router: IMainRouter
    private let interactor: ILoginInteractor

    private weak var view: LoginRegisterVC?

    // MARK: - Lifecycle

    init(router: IMainRouter, interactor: ILoginInteractor) {
        self.router = router
        self.interactor = interactor
    }

    // MARK: - Functions

    func viewDidLoad(view: LoginRegisterVC) {
        self.view = view
    }

    func sendRegistrationRequest(login: Login) {
        interactor.sendRegisterRequest(login: login)
    }

    func checkKeyChain() {

        interactor.checkKeyChain()
    }

    func validateField(text: String, filed: TextFields) {
        interactor.validateText(text: text, field: filed)
    }

    func getUser(login: Login) {
        interactor.sendRegisterRequest(login: login)
    }

    func authUser(user: Login) {
        interactor.sendAuthRequest(login: user)
    }

}


// MARK: - Interactor Output
extension LoginRegisterPresenter: ILoginInteractorOutput {

    func showGreenBorder(field: TextFields) {
        view?.showGreenBorderField(field: field)
    }
    
    func showRedBorder(field: TextFields, errorText: String) {
        view?.showRedBorderField(field: field, errorText: errorText)
    }

    func showRegisterScreen() {
        view?.showRegistrationScreen()
    }
    
    func showLoginScreen() {
        view?.showViewLoginScreen()
    }
    
    
    func showErrorAlert(error: any Error) {
        view?.showAlert(error: error)
    }

    func goToCoffeeShops(request: User) {
        router.goToCofeeShops(user: request)
    }
    
    
}
