enum TextFields {
    case email
    case password
    case repeatPassword
}

enum ValidationErrors: Error {
    case emptyField
    case invalidEmail
    case invalidPassword
    case invalidRepeatPassword
}

protocol IValidatorService: AnyObject {
    func validateField(text: String, textFields: TextFields, completion: (Result<Bool, ValidationErrors>) -> Void)
}

final class Validator: IValidatorService {

    private var password = ""

    func validateField(text: String, textFields: TextFields, completion: (Result<Bool, ValidationErrors>) -> Void) {
        switch textFields {
        case .email:
            if text.isEmpty {
                completion(.failure(.emptyField))
            }
            if !text.contains("@") {
                completion(.failure(.invalidEmail))
            }
            else {
                completion(.success(true))
            }
        case .password:
            if text.isEmpty {
                completion(.failure(.emptyField))
            }

            if text.count < 6 {
                completion(.failure(.invalidPassword))
            }
            else {
                password = text
                completion(.success(true))
            }
        case .repeatPassword:
            if text != password {
                completion(.failure(.invalidRepeatPassword))
            } else {
                completion(.success(true))
            }
        }
    }

}

