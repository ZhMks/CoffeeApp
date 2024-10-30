protocol IMenuPresenter: AnyObject {
    init(interactor: IMenuInteractor, router: IMenuRouter)
    func dismissView()
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
}


// MARK: - Interactor output
extension MenuPresenter: IMenuInteractorOutput {
    
}
