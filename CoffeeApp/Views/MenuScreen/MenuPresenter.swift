protocol IMenuPresenter: AnyObject {
    init(interactor: IMenuInteractor, router: IMenuRouter)
    func dismissView()
    func fetchMenuForShop()
}

protocol IMenuView: AnyObject {
    
}

final class MenuPresenter: IMenuPresenter {
    private let interactor: IMenuInteractor
    private let router: IMenuRouter

    init(interactor: IMenuInteractor, router: IMenuRouter) {
        self.interactor = interactor
        self.router = router
    }

    func dismissView() {
        router.popViewController()
    }

    func fetchMenuForShop() {
        interactor.fetchMenuForShop()
    }
}


// MARK: - Interactor output
extension MenuPresenter: IMenuInteractorOutput {
    
}
