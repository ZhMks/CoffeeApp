import Foundation


protocol IDataSourceService {
    init(decoder: IDecoderService)
    func getUser(_ data: Data?, completion: @escaping (Result<User, Error>) -> Void)
    func getCoffeeShops(_ data: Data?, completion: @escaping (Result<[CoffeeShopsModel], Error>) -> Void)
    func getMenuForShop(data: Data?, completion: @escaping (Result<[MenuItemModel], Error>) -> Void)
}

final class DataSourceService: IDataSourceService {

    private let decoder: IDecoderService



    init(decoder: any IDecoderService) {
        self.decoder = decoder
    }

    func getUser(_ data: Data?, completion: @escaping (Result<User, Error>) -> Void) {
        decoder.decode(type: NetworkModel.self, data) { result in
            switch result {
            case .success(let decodedModel):
                if let decodedModel = decodedModel {
                    let newUser = User(token: decodedModel.token,
                                       lifetime: decodedModel.lifetime)
                    completion(.success(newUser))
                }
            case .failure(let failure):
                completion(.failure(failure))
                print(failure.localizedDescription)
            }
        }
    }

    func getCoffeeShops(_ data: Data?, completion: @escaping (Result<[CoffeeShopsModel], Error>) -> Void) {
        var coffeeShopsArray: [CoffeeShopsModel] = []
        decoder.decode(type: [CoffeeShopsNetworkModel].self, data) { result in
            switch result {
            case .success(let coffeeShops):
                guard let coffeeShops = coffeeShops else {
                    let error = NSError()
                    return completion(.failure(error))
                }
                coffeeShopsArray = coffeeShops.map({ model in
                    CoffeeShopsModel(id: model.id, name: model.name, point: CoffeeShopPoint(latitude: model.point?.latitude ?? "0", longitude: model.point?.longitude ?? "0"))
                })
                completion(.success(coffeeShopsArray))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }

    func getMenuForShop(data: Data?, completion: @escaping (Result<[MenuItemModel], Error>) -> Void) {
        var menuItemsArray: [MenuItemModel] = []

        decoder.decode(type: [MenuItemsNetworkModel].self, data) { result in
            switch result {
            case .success(let success):
                guard let succes = success else {
                    let error = NSError()
                   return completion(.failure(error))
                }
                menuItemsArray = succes.map({ model in
                    MenuItemModel(name: model.name, image: model.image, price: model.price, id: model.id)
                })
                completion(.success(menuItemsArray))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
