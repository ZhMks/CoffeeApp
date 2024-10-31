protocol IPayPresenter: AnyObject {
    init(interactor: IPayInteractor, router: IPayRouter)
    func dismissView()
}

protocol IPayView: AnyObject {
}


final class PayPresenter: IPayPresenter {
    
    private let interactor: IPayInteractor
    private let router: IPayRouter

    init(interactor: IPayInteractor, router: IPayRouter) {
        self.interactor = interactor
        self.router = router
    }

    func dismissView() {
        router.dismissView()
    }
}


// MARK: - Interactor output
extension PayPresenter: IPayInteractorOutput {

}
