import Alamofire
import CoreLocation

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
    private let coreLocationManager: LocationManager

    // MARK: - Lifecycle
    init(dataSource: IDataSourceService, user: User, coreLocation: LocationManager) {
        self.dataSource = dataSource
        self.user = user
        self.coreLocationManager = coreLocation
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
                        self?.interactorOutput?.updateTableViewWithData(data: modelsArray)
                    }
                case .failure(let failure):
                    self?.interactorOutput?.showError(error: failure)
                }
            })
        }
    }

    func getDestinationDifference() {
        
    }
}

class LocationManager: NSObject, CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print()
    }
}
