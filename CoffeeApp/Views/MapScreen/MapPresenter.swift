protocol IMapPresenter: AnyObject {
func updateData()
    func viewDidLoad(view: IMapView)
    func dimsiss()
}

protocol IMapView: AnyObject {
    func updateData(data: [CoffeeShopsModel])
}

final class MapPresenter: IMapPresenter {

    weak var view: IMapView?
    private let interactor: IMapInteractor
    private let router: IMapRouter
    private var dataForView: [CoffeeShopsModel]?

    init(interactor: IMapInteractor, router: IMapRouter) {
        self.interactor = interactor
        self.router = router
    }

    func updateData() {
        interactor.updateData()
    }

    func viewDidLoad(view: IMapView) {
        self.view = view
    }

    func dimsiss() {
        router.dismiss()
    }



}


// MARK: - Interactor output

extension MapPresenter: IMapInteractorOutput {
    func dataUpdated(data: [CoffeeShopsModel]) {
        self.dataForView = data
        guard let dataForView = self.dataForView else { return }
        view?.updateData(data: dataForView)
    }
}
