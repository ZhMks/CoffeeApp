protocol IMenuPresenter: AnyObject {
    init(interactor: IMenuInteractor, router: IMenuRouter)
    func dismissView()
    func fetchMenuForShop()
    func viewDidLoad(view: MenuVC)
    func goToPayment()
    func addToCart(item: OrderModel)
    func removeFromCart(item: OrderModel)
}

protocol IMenuView: AnyObject {
    func updateData(data: [MenuItemModel])
    func showAlert()
}

final class MenuPresenter: IMenuPresenter {
    private let interactor: IMenuInteractor
    private let router: IMenuRouter
    private var data: [MenuItemModel]?
    weak var view: MenuVC?
    private var orderData: [OrderModel]?

    init(interactor: IMenuInteractor, router: IMenuRouter) {
        self.interactor = interactor
        self.router = router
    }

    func viewDidLoad(view: MenuVC) {
        self.view = view
    }

    func dismissView() {
        router.popViewController()
    }

    func fetchMenuForShop() {
        interactor.fetchMenuForShop()
    }

    func goToPayment() {
        if let order = orderData {
            if order.isEmpty {
                view?.showAlert()
            } else {
                print("Order before showing PAYSCREEN: \(order)")
                router.goToPayScree(order: order)
            }
        } else {
            view?.showAlert()
        }
    }

    func addToCart(item: OrderModel) {
        interactor.addToCartItem(item: item)
    }

    func removeFromCart(item: OrderModel) {
        interactor.removeFromCartItem(item: item)
    }
}


// MARK: - Interactor output
extension MenuPresenter: IMenuInteractorOutput {
    func updateOrderData(data: [OrderModel]) {
        self.orderData = data
        print("Order: \(self.orderData!)")
    }
    
    func updateMenuData(data: [MenuItemModel]) {
        self.data = data
        guard let unwrapedData = self.data else { return }
        view?.updateData(data: unwrapedData)
    }
}
