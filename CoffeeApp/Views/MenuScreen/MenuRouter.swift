import UIKit

protocol IMenuRouter: AnyObject {
    func popViewController()
    func goToPayScree(order: [OrderModel])
}

final class MenuRouter: IMenuRouter {
    weak var mainController: UIViewController?

    func popViewController() {
        mainController?.navigationController?.popViewController(animated: true)
    }

    func goToPayScree(order: [OrderModel]) {
        let payScreen = ModuleBuilder.shared.createPayScreen(order: order)
        mainController?.navigationController?.pushViewController(payScreen, animated: true)
    }
}

