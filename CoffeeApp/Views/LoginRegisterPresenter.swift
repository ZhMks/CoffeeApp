
import Foundation
import Alamofire

protocol ILoginRegisterPresenter: AnyObject {
    init(router: IMainRouter, interactor: ILoginInteractor)
    func viewDidLoad(view: LoginRegisterScreen)
    func sendRegistrationRequest(login: Login)
}

final class LoginRegisterPresenter: ILoginRegisterPresenter {

    private let router: IMainRouter
    private let interactor: ILoginInteractor

    private weak var view: LoginRegisterScreen?

    init(router: IMainRouter, interactor: ILoginInteractor) {
        self.router = router
        self.interactor = interactor
    }

    func viewDidLoad(view: LoginRegisterScreen) {
        self.view = view
    }

    func sendRegistrationRequest(login: Login) {
      //  interactor.sendRegisterRequest(login: login)
    }
}


extension LoginRegisterPresenter: ILoginInteractorOutput {
    func printError(error: any Error) {
        print(error.localizedDescription)
    }

    func printData(request: User) {
        print(request.token)
    }
    
    
}
