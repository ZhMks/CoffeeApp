import Alamofire
import Foundation

protocol ILoginInteractor: AnyObject {
    func sendRegisterRequest(login: Login)
    init(dataSource: IDataSourceService)
}

protocol ILoginInteractorOutput: AnyObject {
    func printData(request: User)
    func printError(error: Error)
}

final class LoginRegisterInteractor: ILoginInteractor {
    weak var interactorOutput: ILoginInteractorOutput?
    private let dataSource: IDataSourceService

    init( dataSource: IDataSourceService) {
        self.dataSource = dataSource
    }

    func sendRegisterRequest(login: Login) {
        let url = URL(string: "http://147.78.66.203:3210/auth/register")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body = ["login": "value1", "password": "value2"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "accept")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response as? HTTPURLResponse {
                print(response.statusCode)
            }
        }
        task.resume()

//        AF.request("http://147.78.66.203:3210/auth/register",
//                   method: .post,
//                   parameters: body,
//                   encoder: URLEncodedFormParameterEncoder(destination: .httpBody)).response { [weak self] response in
//            self?.dataSource.getUser(response.data, completion: { [weak self] user in
//                switch user {
//                case .success(let newUser):
//                    self?.interactorOutput?.printData(request: newUser)
//                case .failure(let failure):
//                    self?.interactorOutput?.printError(error: failure)
//                }
//            })
//        }
    }

}
