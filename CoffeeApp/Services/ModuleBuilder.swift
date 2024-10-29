import UIKit

final class ModuleBuilder {
    static let shared = ModuleBuilder()

    private init () {}

    func build() -> UIViewController {
        let loginRegisterRouter = LoginRegisterRouter()
        let loginRegisterInteractor = LoginRegisterInteractor()
        let loginRegisterPresenter = LoginRegisterPresenter(router: loginRegisterRouter, interactor: loginRegisterInteractor)
        let loginRegisterVC = LoginRegisterVC(presenter: loginRegisterPresenter)

        loginRegisterInteractor.interactorOutput = loginRegisterPresenter
        
        return loginRegisterVC
    }
}
