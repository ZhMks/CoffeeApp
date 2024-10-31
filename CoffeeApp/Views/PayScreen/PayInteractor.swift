protocol IPayInteractor: AnyObject {

}

protocol IPayInteractorOutput: AnyObject {

}


final class PayInteractor: IPayInteractor {
    weak var delegate: IPayInteractorOutput?
    var order: [[MenuItemModel]]?
}
