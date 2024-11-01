protocol IPayInteractor: AnyObject {
func updateData()
}

protocol IPayInteractorOutput: AnyObject {
    func dataUpdated(order: [OrderModel])
}


final class PayInteractor: IPayInteractor {
    weak var delegate: IPayInteractorOutput?
    var order: [OrderModel]

    init( order: [OrderModel]) {
        self.order = order
    }

    func updateData() {
        delegate?.dataUpdated(order: self.order)
    }
}
