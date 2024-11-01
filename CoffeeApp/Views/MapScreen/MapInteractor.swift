protocol IMapInteractor: AnyObject {
func updateData()
}

protocol IMapInteractorOutput: AnyObject {
    func dataUpdated(data: [CoffeeShopsModel])
}

final class MapInteractor: IMapInteractor {
    
    weak var delegate: IMapInteractorOutput?
    private let shops: [CoffeeShopsModel]

    init( shops: [CoffeeShopsModel]) {
        self.shops = shops
    }

    func updateData() {
        delegate?.dataUpdated(data: self.shops)
    }

}

