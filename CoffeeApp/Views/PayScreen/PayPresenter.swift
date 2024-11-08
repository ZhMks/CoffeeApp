protocol IPayPresenter: AnyObject {
    init(interactor: IPayInteractor, router: IPayRouter)
    func dismissView()
    func viewDidLoad(view: PayVC)
    func updateData()
    func removeItem(item: OrderModel)
    func addItem(item: OrderModel)
}

protocol IPayView: AnyObject {
    func updateViewData(order: [OrderModel])
}


final class PayPresenter: IPayPresenter {
    
    private let interactor: IPayInteractor
    private let router: IPayRouter
    weak var view: PayVC?
    private var order: [OrderModel]?

    init(interactor: IPayInteractor, router: IPayRouter) {
        self.interactor = interactor
        self.router = router
    }

    func dismissView() {
        router.dismissView()
    }

    func viewDidLoad(view: PayVC) {
        self.view = view
    }

    func updateData() {
        interactor.updateData()
    }

    func removeItem(item: OrderModel) {
        interactor.removeItem(item: item)
    }

    func addItem(item: OrderModel) {
        interactor.addItem(item: item)
    }
}


// MARK: - Interactor output
extension PayPresenter: IPayInteractorOutput {
    
    func dataUpdated(order: [OrderModel]) {
        self.order = order
        guard let unwrappedOrder = self.order else { return }
        view?.updateViewData(order: unwrappedOrder)
    }

}
