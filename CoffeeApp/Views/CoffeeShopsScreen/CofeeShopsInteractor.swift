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

protocol LocationDelegate: AnyObject {
    func authorisationGranted()
}

final class CoffeeShopInteractor: ICoffeeShopInteractor {

    // MARK: - Properties
    private let dataSource: IDataSourceService
    let user: User
    weak var interactorOutput: ICoffeeShopsInteractorOutput?
    var modelsArray: [CoffeeShopsModel] = []
    private let coreLocationManager: LocationManager

    // MARK: - Lifecycle
    init(dataSource: IDataSourceService, user: User, coreLocation: LocationManager) {
        self.dataSource = dataSource
        self.user = user
        self.coreLocationManager = coreLocation
        coreLocation.delegate = self
    }


    // MARK: - Functions
    func fetchCoffeeShops() {
        coreLocationManager.requestAuthorisation()
        let headers: HTTPHeaders = [
            "Content-Type" : "application/json",
            "Authorization" : "Bearer \(user.token)"
        ]
        let urlString = "http://147.78.66.203:3210/locations"
        AF.request(urlString,
                   method: .get,
                   headers: headers).response { [weak self] response in
            self?.dataSource.getCoffeeShops(response.data, completion: { [weak self] result in
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            for (index, model) in self.modelsArray.enumerated() {
                let lon = model.point.longitude
                let lat = model.point.latitude

                guard let longitude = Double(lon), let latitude = Double(lat) else { return  }
                guard let distance = self.coreLocationManager.beginGettingLocation(lat: latitude, long: longitude) else { return }

                self.modelsArray[index].destinationDifference = String(Int(distance))
            }
            self.interactorOutput?.destinationDifference(newData: self.modelsArray)
        }
    }

}

// MARK: - Location Delegate
extension CoffeeShopInteractor: LocationDelegate {
    func authorisationGranted() {
        getDestinationDifference()
    }
}

// MARK: - Location Manager
final class LocationManager: NSObject, CLLocationManagerDelegate {

    let manager: CLLocationManager

    var userLocation: CLLocation?

    weak var delegate: LocationDelegate?

    override init() {
        manager = CLLocationManager()
        super.init()

        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined, .restricted, .denied:
            manager.stopUpdatingLocation()
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
            delegate?.authorisationGranted()
        @unknown default:
            print("Set status to unknown")
        }
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
        guard let userLocation = userLocation else { return nil }
        let destinationLocation = CLLocation(latitude: lat, longitude: long)
        return userLocation.distance(from: destinationLocation) / 1000
    }

    func requestAuthorisation() {
        manager.requestWhenInUseAuthorization()
    }
}
