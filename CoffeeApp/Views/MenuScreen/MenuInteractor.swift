import Alamofire

protocol IMenuInteractor: AnyObject {
    init (dataSource: IDataSourceService, id: Int)
    func fetchMenuForShop()
}

protocol IMenuInteractorOutput: AnyObject {
}

final class MenuInteractor: IMenuInteractor {

    // MARK: - Properties
    weak var output: IMenuInteractorOutput?

    private let dataSource: IDataSourceService
    private let id: Int

    // MARK: - Lifecycle
    init (dataSource: IDataSourceService, id: Int) {
        self.dataSource = dataSource
        self.id = id
    }

    // MARK: - Functions
    func fetchMenuForShop() {
        let id = String(id)
        let urlString = "http://147.78.66.203:3210/location/\(id)/menu"
//        let headers: HTTPHeaders = [
//             "Content-Type" : "application/json",
//             "Authorization" : "Bearer \(user.token)"
//         ]
        print("URLSTRING: \(urlString)")
        AF.request(urlString,
                   method: .get).response { [weak self] response in
            print("Response: \(response.response?.statusCode)")
            self?.dataSource.getMenuForShop(data: response.data, completion: { result in
                switch result {
                case .success(let success):
                    print(success)
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            })
        }
    }
}
