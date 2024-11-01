import UIKit

protocol ICoffeeShopsRouter: AnyObject {
    func dismissView()
    func goToMenu(id: Int, token: String)
    func goToMapView(shops: [CoffeeShopsModel])
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

    func goToMapView(shops: [CoffeeShopsModel]) {
        let mapVC = ModuleBuilder.shared.createMapScreen(shops: shops)
        mainController?.navigationController?.pushViewController(mapVC, animated: true)
    }
}

