protocol ICoffeShopPresenter: AnyObject {
    func viewDidLoad(view: CoffeeShopsVC)
    func fetchCoffeeShops()
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

}

extension CoffeeShopsPresenter: ICoffeeShopsInteractorOutput {

    func updateTableViewWithData(data: [CoffeeShopsModel]) {
        print("Data inside Presenter: \(data)")
        self.dataInfo = data
        view?.updateTableViewWithData(data: self.dataInfo)
    }
    
    func showError(error: any Error) {
        view?.showError(error: error)
    }
    

}
