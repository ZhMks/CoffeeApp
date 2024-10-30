import UIKit

final class ModuleBuilder {
    static let shared = ModuleBuilder()

    private init () {}

    func createRegisterVC() -> UIViewController {
        let loginRegisterRouter = LoginRegisterRouter()
        let decoder = DecoderService()
        let validatorService = Validator()
        let dataSource = DataSourceService(decoder: decoder)
        let loginRegisterInteractor = LoginRegisterInteractor(dataSource: dataSource, validationService: validatorService)
        let loginRegisterPresenter = LoginRegisterPresenter(router: loginRegisterRouter, interactor: loginRegisterInteractor)
        let loginRegisterVC = LoginRegisterVC(presenter: loginRegisterPresenter)

        loginRegisterRouter.mainController = loginRegisterVC
        loginRegisterInteractor.interactorOutput = loginRegisterPresenter

        return loginRegisterVC
    }

    func createCoffeeShopsVC(user: User) -> UIViewController {
        let decoder = DecoderService()
        let dataSource = DataSourceService(decoder: decoder)
        let interactor = CoffeeShopInteractor(dataSource: dataSource, user: user)
        let router = CoffeeShopsRouter()
        let presenter = CoffeeShopsPresenter(router: router, interactor: interactor)
        let coffeeShopVC = CoffeeShopsVC(presenter: presenter)

        interactor.interactorOutput = presenter

        return coffeeShopVC
    }
}
