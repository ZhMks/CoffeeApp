import UIKit

protocol ICoffeeShopsRouter: AnyObject {
    func dismissView()
    func goToMenu(id: Int, token: String)
}

final class CoffeeShopsRouter: ICoffeeShopsRouter {

    weak var mainController: UIViewController?

    func dismissView() {
        mainController?.navigationController?.popViewController(animated: true)
    }

    func goToMenu(id: Int, token: String) {
        let menuVC = ModuleBuilder.shared.createMenuForShop(id: id, token: token)
        mainController?.navigationController?.pushViewController(menuVC, animated: true)
    }
}

