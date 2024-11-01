import UIKit

protocol IMapRouter: AnyObject {
func dismiss()
}

final class MapRouter: IMapRouter {
    weak var mainController: UIViewController?
    func dismiss() {
        mainController?.navigationController?.popViewController(animated: true)
    }
}

