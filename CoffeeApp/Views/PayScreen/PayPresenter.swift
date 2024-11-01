protocol IPayPresenter: AnyObject {
    init(interactor: IPayInteractor, router: IPayRouter)
    func dismissView()
    func viewDidLoad(view: PayVC)
    func updateData()
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
}


// MARK: - Interactor output
extension PayPresenter: IPayInteractorOutput {
    
    func dataUpdated(order: [OrderModel]) {
        self.order = order
        guard let unwrappedOrder = self.order else { return }
        view?.updateViewData(order: unwrappedOrder)
    }

}
