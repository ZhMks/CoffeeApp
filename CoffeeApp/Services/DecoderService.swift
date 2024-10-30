import Foundation

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
    let latitude: Double?
    let longitude: Double?
}

enum Networkerror: Error {
    case alreadyExists
    case wrongData
    case invalidField
}

protocol IDecoderService {
    func decode<T: Decodable>(type: T.Type, _ data: Data?, completion: @escaping(Result<T?, Networkerror>) -> Void)
}

final class DecoderService: IDecoderService {

    func decode<T: Decodable>(type: T.Type, _ data: Data?, completion: @escaping(Result<T?, Networkerror>) -> Void)  {
        guard let data = data else { return  completion(.failure(.alreadyExists))}
        let decoder = JSONDecoder()
        do {
            let decodedModel = try decoder.decode(type, from: data)
            completion(.success(decodedModel))
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print(error.localizedDescription)
            completion(.failure(.wrongData))
        }
    }
    

}
