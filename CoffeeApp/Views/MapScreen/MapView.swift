import YandexMapsMobile
import SnapKit
import UIKit
import MapKit

final class MapView: UIView {
    // MARK: - Properties
    private var coffeeShops: [CoffeeShopsModel] = []

    private lazy var mapView: YMKMapView = {
        let mapView = YMKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        layoutUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: - Functions
    private func setupUI() {
        self.addSubview(mapView)
    }

    private func layoutUI() {
        mapView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }

    private func enableMap() {
        let model = coffeeShops.first
        guard let lat = model?.point.latitude, let lon = model?.point.longitude else { return }
        print("Lat: \(lat), lon: \(lon)")
        mapView.mapWindow.map.move(
            with: YMKCameraPosition(
                target: YMKPoint(latitude: Double(lat)!, longitude: Double(lon)!),
                zoom: 2.0,
                azimuth: 0,
                tilt: 0
            ),
            animation: YMKAnimation(type: YMKAnimationType.smooth, duration: 5),
            cameraCallback: nil
        )
    }

    private func move(_ map: YMKMap) {
        let model = coffeeShops.first
        guard let lat = model?.point.latitude, let lon = model?.point.longitude else { return }
        let cameraPosition = YMKCameraPosition(target: YMKPoint(latitude: Double(lat)!, longitude: Double(lon)!),
                                               zoom: 3.0,
                                               azimuth: 0,
                                               tilt: 0)
        map.move(with: cameraPosition, animation: YMKAnimation(type: .smooth, duration: 1.0))
    }

    private func addPlacemark(_ map: YMKMap, lat: Double, lon: Double, name: String) {
        let image = UIImage(named: "mapMark") ?? UIImage()
        let placemark = map.mapObjects.addPlacemark()
        placemark.geometry = YMKPoint(latitude: lat, longitude: lon)
        placemark.setIconWith(image)
        placemark.setTextWithText(
            "\(name)",
            style: YMKTextStyle(
                size: 10.0,
                color: UIColor(red: 132/255, green: 99/255, blue: 64/255, alpha: 1),
                outlineWidth: 2.0,
                outlineColor: .white,
                placement: .bottom,
                offset: 0.0,
                offsetFromIcon: true,
                textOptional: false

            )
        )
    }

    private func addPlacemarks() {
       for model in coffeeShops {
           DispatchQueue.main.async {
               guard let lat = Double(model.point.latitude), let lon = Double(model.point.longitude) else { return }
               self.addPlacemark(self.mapView.mapWindow.map, lat: lat, lon: lon, name: model.name)
           }
        }
    }

    func updateDataForView(data: [CoffeeShopsModel]) {
        self.coffeeShops = data
        enableMap()
        addPlacemarks()
    }
}
