
import Foundation
import Alamofire

protocol ILoginRegisterPresenter: AnyObject {
    init(router: IMainRouter, interactor: ILoginInteractor)
    func viewDidLoad(view: LoginRegisterVC)
    func sendRegistrationRequest(login: Login)
    func pushCoffeeShops()
}

protocol IMainScreenView: AnyObject {
    
}

final class LoginRegisterPresenter: ILoginRegisterPresenter {

    private let router: IMainRouter
    private let interactor: ILoginInteractor

    private weak var view: LoginRegisterVC?

    init(router: IMainRouter, interactor: ILoginInteractor) {
        self.router = router
        self.interactor = interactor
    }

    func viewDidLoad(view: LoginRegisterVC) {
        self.view = view
    }

    func sendRegistrationRequest(login: Login) {
        interactor.sendRegisterRequest(login: login)
    }

    func pushCoffeeShops() {
        router.goToCofeeShops()
    }
}


// MARK: - Interactor Output
extension LoginRegisterPresenter: ILoginInteractorOutput {
    
    func printError(error: any Error) {
        print(error.localizedDescription)
    }

    func printData(request: User) {
        print(request.token)
    }
    
    
}
