struct User {
    let token: String
    let lifetime: Int32
}


struct Login: Codable {
    var login: String
    var password: String
}
