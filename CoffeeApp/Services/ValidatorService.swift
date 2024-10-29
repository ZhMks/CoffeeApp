

protocol IValidatorService: AnyObject {
    func validateField(email: String, password: String)
}

final class Validator: IValidatorService {

    func validateField(email: String, password: String) {

    }

}

