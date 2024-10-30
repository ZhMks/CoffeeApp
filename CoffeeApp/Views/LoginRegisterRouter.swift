
import UIKit


protocol IMainRouter: AnyObject {
    func goToCofeeShops(user: User)
}


final class LoginRegisterRouter: IMainRouter {
    
    weak var mainController: UIViewController?

    func goToCofeeShops(user: User) {
        guard let mainController = mainController else { return }
        let coffeeShopsVC = ModuleBuilder.shared.createCoffeeShopsVC(user: user)
        mainController.navigationController?.pushViewController(coffeeShopsVC, animated: true)
    }

}
