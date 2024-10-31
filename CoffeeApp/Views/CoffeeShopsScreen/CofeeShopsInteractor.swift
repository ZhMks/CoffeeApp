import Alamofire
import CoreLocation

protocol ICoffeeShopInteractor: AnyObject {
    func fetchCoffeeShops()
    func getDestinationDifference()
}

protocol ICoffeeShopsInteractorOutput: AnyObject {
    func updateTableViewWithData(data: [CoffeeShopsModel])
    func showError(error: Error)
    func destinationDifference(newData: [CoffeeShopsModel])
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
        coreLocationManager.startUpdatingLocation()
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
        for (index, model) in modelsArray.enumerated() {
            let lon = model.point.longitude
            let lat = model.point.latitude

            guard let longitude = Double(lon), let latitude = Double(lat) else { return  }
            guard let distance = coreLocationManager.beginGettingLocation(lat: latitude, long: longitude) else { return }

            modelsArray[index].destinationDifference = String(Int(distance))
        }
        interactorOutput?.destinationDifference(newData: self.modelsArray)
    }

    func requestUpdateLocation() {
        coreLocationManager.startUpdatingLocation()
    }
}

class LocationManager: NSObject, CLLocationManagerDelegate {

    let manager: CLLocationManager

    var userLocation: CLLocation?

    override init() {
        manager = CLLocationManager()
        super.init()

        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }


    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.last
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            print("Authirsed always")
        case .notDetermined, .denied, .restricted:
            print("notdetermined")
        @unknown default:
            print("Unknown error")
        }
    }


    func beginGettingLocation(lat: Double, long: Double) -> Double? {
        print("Shop loc: lat \(lat), lon \(long)")
        guard let userLocation = userLocation else { return nil }
        let destinationLocation = CLLocation(latitude: lat, longitude: long)
        return userLocation.distance(from: destinationLocation) / 1000
    }

    func startUpdatingLocation() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
}
