
import UIKit


protocol IMainRouter: AnyObject {
    func goToCofeeShops()
}


final class LoginRegisterRouter: IMainRouter {
    
    weak var mainController: UIViewController?

    func goToCofeeShops() {
        guard let mainController = mainController else { return }
        let coffeeShopsVC = ModuleBuilder.shared.createCoffeeShopsVC()
        mainController.navigationController?.pushViewController(coffeeShopsVC, animated: true)
    }

}
