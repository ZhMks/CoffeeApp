struct CoffeeShopsModel {
    let id: Int
    let name: String
    let point: CoffeeShopPoint
    var destinationDifference: String?
}

struct CoffeeShopPoint {
    let latitude: String
    let longitude: String
}
