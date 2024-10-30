import UIKit

protocol ICoffeeShopsRouter: AnyObject {
    func dismissView()
    func goToMenu(id: Int)
}

final class CoffeeShopsRouter: ICoffeeShopsRouter {

    weak var mainController: UIViewController?

    func dismissView() {
        mainController?.navigationController?.popViewController(animated: true)
    }

    func goToMenu(id: Int) {
        let menuVC = ModuleBuilder.shared.createMenuForShop(id: id)
        mainController?.navigationController?.pushViewController(menuVC, animated: true)
    }
}

