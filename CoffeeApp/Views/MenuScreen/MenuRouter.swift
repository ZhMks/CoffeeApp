import UIKit

protocol IMenuRouter: AnyObject {
func popViewController()
}

final class MenuRouter: IMenuRouter {
    weak var mainController: UIViewController?

    func popViewController() {
        mainController?.navigationController?.popViewController(animated: true)
    }
}

