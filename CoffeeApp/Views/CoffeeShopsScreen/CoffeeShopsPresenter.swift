import Foundation
protocol ICoffeShopPresenter: AnyObject {
    func viewDidLoad(view: CoffeeShopsVC)
    func fetchCoffeeShops()
    func dismissView()
    func goToMenuView(id: Int)
}

protocol ICoffeeShopsView: AnyObject {
    func updateTableViewWithData(data: [CoffeeShopsModel])
    func showError(error: Error)
}

final class CoffeeShopsPresenter: ICoffeShopPresenter {
    // MARK: - Properties
    weak var view: CoffeeShopsVC?
    private let router: CoffeeShopsRouter
    private let interactor: CoffeeShopInteractor
    var dataInfo: [CoffeeShopsModel] = []

    // MARK: - Lifecycle
    init(router: CoffeeShopsRouter, interactor: CoffeeShopInteractor) {
        self.router = router
        self.interactor = interactor
    }

    // MARK: - Functions
    func viewDidLoad(view: CoffeeShopsVC) {
        self.view = view
    }

    func fetchCoffeeShops() {
        interactor.fetchCoffeeShops()
    }

    func dismissView() {
        router.dismissView()
    }

    func goToMenuView(id: Int) {
        router.goToMenu(id: id, token: interactor.user.token)
    }

    func goToMapView() {
        router.goToMapView(shops: self.dataInfo)
    }
}

extension CoffeeShopsPresenter: ICoffeeShopsInteractorOutput {

    func destinationDifference(newData: [CoffeeShopsModel]) {
        view?.updateTableViewWithData(data: newData)
    }


    func updateTableViewWithData(data: [CoffeeShopsModel]) {
        self.dataInfo = data
        view?.updateTableViewWithData(data: self.dataInfo)
    }

    func showError(error: any Error) {
        view?.showError(error: error)
    }


}
