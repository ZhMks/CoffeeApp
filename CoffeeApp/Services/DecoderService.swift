import Foundation

struct NetworkModel: Decodable {
    let token: String
    let lifetime: Int32
}

protocol IDecoderService {
    func decode<T: Decodable>(type: T.Type, _ data: Data?, completion: @escaping(Result<T?, Error>) -> Void)
}

final class DecoderService: IDecoderService {

    func decode<T: Decodable>(type: T.Type, _ data: Data?, completion: @escaping(Result<T?, Error>) -> Void)  {
        guard let data = data else { return }
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
            completion(.failure(error))
        }
    }
    

}
