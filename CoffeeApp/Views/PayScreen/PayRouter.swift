import UIKit

protocol IPayRouter: AnyObject {
func dismissView()
}


final class PayRouter: IPayRouter {
    weak var mainController: UIViewController?

    func dismissView() {
        mainController?.navigationController?.popViewController(animated: true)
    }
}
