import Alamofire

protocol ICoffeeShopInteractor: AnyObject {
    func fetchCoffeeShops()
}

protocol ICoffeeShopsInteractorOutput: AnyObject {
    func updateTableViewWithData(data: [CoffeeShopsModel])
    func showError(error: Error)
}

final class CoffeeShopInteractor: ICoffeeShopInteractor {

    // MARK: - Properties
    private let dataSource: IDataSourceService
    private let user: User
    weak var interactorOutput: ICoffeeShopsInteractorOutput?
    var modelsArray: [CoffeeShopsModel] = []

    // MARK: - Lifecycle
    init(dataSource: IDataSourceService, user: User) {
        self.dataSource = dataSource
        self.user = user
    }


    // MARK: - Functions
    func fetchCoffeeShops() {
        let headers: HTTPHeaders = [
            "Content-Type" : "application/json",
            "Authorization" : "Bearer \(user.token)"
        ]
        let urlString = "http://147.78.66.203:3210/locations"
        AF.request(urlString,
                   method: .get,
                   headers: headers).response { [weak self] response in
            self?.dataSource.getCoffeeShops(response.data, completion: { result in
                switch result {
                case .success(let success):
                    self?.modelsArray = success
                    if let modelsArray = self?.modelsArray {
                        print("DataInsideInteractor: \(modelsArray)")
                        self?.interactorOutput?.updateTableViewWithData(data: modelsArray)
                    }
                case .failure(let failure):
                    self?.interactorOutput?.showError(error: failure)
                }
            })
        }
    }
}
