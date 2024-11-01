import Alamofire

protocol IMenuInteractor: AnyObject {
    init (dataSource: IDataSourceService, id: Int, token: String)
    func fetchMenuForShop()
    func addToCartItem(item: OrderModel)
    func removeFromCartItem(item: OrderModel)
}

protocol IMenuInteractorOutput: AnyObject {
    func updateMenuData(data: [MenuItemModel])
    func updateOrderData(data: [OrderModel])
}

final class MenuInteractor: IMenuInteractor {

    // MARK: - Properties
    weak var output: IMenuInteractorOutput?

    private let dataSource: IDataSourceService
    private let id: Int
    private let token: String
    private var menuData: [MenuItemModel]?
    private var orderData: [OrderModel] = []

    // MARK: - Lifecycle
    init (dataSource: IDataSourceService, id: Int, token: String) {
        self.dataSource = dataSource
        self.id = id
        self.token = token
    }

    // MARK: - Functions
    func fetchMenuForShop() {
        let id = String(id)
        let urlString = "http://147.78.66.203:3210/location/\(id)/menu"
        let headers: HTTPHeaders = [
             "Content-Type" : "application/json",
             "Authorization" : "Bearer \(token)"
         ]
        AF.request(urlString,
                   method: .get,
                   headers: headers).response { [weak self] response in
            self?.dataSource.getMenuForShop(data: response.data, completion: { result in
                switch result {
                case .success(let success):
                    self?.menuData = success
                    if let modelsArray = self?.menuData {
                        self?.output?.updateMenuData(data: modelsArray)
                    }
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            })
        }
    }

    func removeFromCartItem(item: OrderModel) {
        for (index, value) in orderData.enumerated() {
            if value.id == item.id {
                orderData[index].totalNumberOfItem = item.totalNumberOfItem
                if orderData[index].totalNumberOfItem == 0 {
                    orderData.remove(at: index)
                }
                output?.updateOrderData(data: orderData)
            } else {
                return
            }
        }
    }

    func addToCartItem(item: OrderModel) {
        for (index, value) in orderData.enumerated() {
            if value.id == item.id {
                orderData[index].totalNumberOfItem += 1
                output?.updateOrderData(data: orderData)
                return
            }
        }
        orderData.append(item)
        output?.updateOrderData(data: orderData)
    }
}
