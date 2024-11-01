protocol IPayInteractor: AnyObject {
func updateData()
    func removeItem(item: OrderModel)
    func addItem(item: OrderModel)
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

    func removeItem(item: OrderModel) {
        for (index, value) in order.enumerated() {
            print("ValueID: \(value.id), itemID: \(item.id)")
            if value.id == item.id {
                order[index].totalNumberOfItem -= 1
                if order[index].totalNumberOfItem == 0 {
                    order.remove(at: index)
                }
                delegate?.dataUpdated(order: order)
            } else {
                continue
            }
        }
    }

    func addItem(item: OrderModel) {
        for (index, value) in order.enumerated() {
            if value.id == item.id {
                order[index].totalNumberOfItem += 1
                delegate?.dataUpdated(order: order)
                return
            }
        }
    }
}
