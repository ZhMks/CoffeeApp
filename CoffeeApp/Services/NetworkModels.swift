struct NetworkModel: Decodable {
    let token: String
    let lifetime: Int32

    private enum CodingKeys: String, CodingKey {
        case token
        case lifetime = "tokenLifetime"
    }
}

struct CoffeeShopsNetworkModel: Decodable {
    let id: Int
    let name: String
    let point: CoffeeShopsNetworkPoint?
}

struct CoffeeShopsNetworkPoint: Decodable {
    let latitude: String?
    let longitude: String?
}

struct MenuItemsNetworkModel: Decodable {
    let name: String
    let id: Int
    let image: String?
    let price: Int
}
