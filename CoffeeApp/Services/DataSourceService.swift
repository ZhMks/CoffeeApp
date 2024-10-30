import Foundation


protocol IDataSourceService {
    init(decoder: IDecoderService)
    func getUser(_ data: Data?, completion: @escaping (Result<User, Error>) -> Void)
    func getCoffeeShops(_ data: Data?, completion: @escaping (Result<CoffeeShopsModel, Error>) -> Void)
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

    func getCoffeeShops(_ data: Data?, completion: @escaping (Result<CoffeeShopsModel, Error>) -> Void) {
        decoder.decode(type: CoffeeShopsNetworkModel.self, data) { result in
            switch result {
            case .success(let coffeeShops):
                print(coffeeShops)
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
