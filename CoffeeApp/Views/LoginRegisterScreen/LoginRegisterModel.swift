struct User {
    let token: String
    let lifetime: Int32
}


struct Login: Codable {
    let login: String
    let password: String
}
