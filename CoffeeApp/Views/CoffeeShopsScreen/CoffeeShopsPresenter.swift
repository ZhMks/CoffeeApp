protocol ICoffeShopPresenter {
    func viewDidLoad(view: CoffeeShopsVC)
}

final class CoffeeShopsPresenter: ICoffeShopPresenter {
    weak var view: CoffeeShopsVC?

    func viewDidLoad(view: CoffeeShopsVC) {
        self.view = view
    }

}
