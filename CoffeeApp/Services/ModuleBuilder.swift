import UIKit

final class ModuleBuilder {
    static let shared = ModuleBuilder()

    private init () {}

    func createRegisterVC() -> UIViewController {
        let loginRegisterRouter = LoginRegisterRouter()
        let decoder = DecoderService()
        let dataSource = DataSourceService(decoder: decoder)
        let loginRegisterInteractor = LoginRegisterInteractor(dataSource: dataSource)
        let loginRegisterPresenter = LoginRegisterPresenter(router: loginRegisterRouter, interactor: loginRegisterInteractor)
        let loginRegisterVC = LoginRegisterVC(presenter: loginRegisterPresenter)

        loginRegisterRouter.mainController = loginRegisterVC
        loginRegisterInteractor.interactorOutput = loginRegisterPresenter

        return loginRegisterVC
    }

    func createCoffeeShopsVC() -> UIViewController {
        let presenter = CoffeeShopsPresenter()
        let interactor = CoffeeShopInteractor()
        let coffeeShopVC = CoffeeShopsVC(presenter: presenter)
        return coffeeShopVC
    }
}
