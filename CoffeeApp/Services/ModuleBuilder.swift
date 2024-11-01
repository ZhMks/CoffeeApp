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
        let locationManager = LocationManager()
        let interactor = CoffeeShopInteractor(dataSource: dataSource, user: user, coreLocation: locationManager)
        let router = CoffeeShopsRouter()
        let presenter = CoffeeShopsPresenter(router: router, interactor: interactor)
        let coffeeShopVC = CoffeeShopsVC(presenter: presenter)

        interactor.interactorOutput = presenter
        router.mainController = coffeeShopVC

        return coffeeShopVC
    }

    func createMenuForShop(id: Int, token: String) -> UIViewController {

        let decoder = DecoderService()
        let dataSource = DataSourceService(decoder: decoder)
        let interactor = MenuInteractor(dataSource: dataSource, id: id, token: token)
        let router = MenuRouter()
        let presenter = MenuPresenter(interactor: interactor, router: router)
        let menuVC = MenuVC(presenter: presenter)

        interactor.output = presenter
        router.mainController = menuVC

        return menuVC
    }

    func createPayScreen(order: [OrderModel]) -> UIViewController {
        let payInteractor = PayInteractor(order: order)
        let payRouter = PayRouter()
        let payPresenter = PayPresenter(interactor: payInteractor, router: payRouter)
        let payVC = PayVC(presenter: payPresenter)

        payInteractor.order = order
        payRouter.mainController = payVC
        payInteractor.delegate = payPresenter

        return payVC
    }

    func createMapScreen(shops: [CoffeeShopsModel]) -> UIViewController {

        let mapInteractor = MapInteractor(shops: shops)
        let mapRouter = MapRouter()
        let mapPresenter = MapPresenter(interactor: mapInteractor, router: mapRouter)
        let mapVC = MapVC(presenter: mapPresenter)

        mapInteractor.delegate = mapPresenter
        mapPresenter.view = mapVC
        mapRouter.mainController = mapVC

        return mapVC
    }
}
