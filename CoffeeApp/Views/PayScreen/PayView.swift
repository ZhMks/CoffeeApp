import SnapKit
import UIKit

final class PayView: UIView {

    // MARK: - Properties
    private lazy var payOrderTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private lazy var informationLabel: UILabel = {
        let informationLabel = UILabel()
        informationLabel.translatesAutoresizingMaskIntoConstraints = false
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(red: 132/255, green: 99/255, blue: 64/255, alpha: 1),
            .kern : -0.12,
            .font : UIFont.systemFont(ofSize: 24, weight: .medium),
        ]
        let text = """
                   Время ожидания заказа
                         15 минут!
                   Спасибо, что выбрали нас!
                   """
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttributes(attributes, range: NSRange(location: 0, length: text.count))
        informationLabel.attributedText = attributedText
        return informationLabel
    }()
    
    private lazy var payButton: UIButton = {
        let payButton = UIButton(type: .system)
        payButton.translatesAutoresizingMaskIntoConstraints = false
        payButton.backgroundColor = UIColor(red: 52/255, green: 25/255, blue: 26/255, alpha: 1)
        let titleString = NSMutableAttributedString(string: "Оплатить")
        let attributes: [NSAttributedString.Key : Any] = [
            .font: UIFont.boldSystemFont(ofSize: 18),
            .foregroundColor: UIColor(red: 246/255, green: 229/255, blue: 209/255, alpha: 1),
            .kern: -0.14
        ]
        titleString.addAttributes(attributes, range: NSRange(location: 0, length: titleString.length))
        payButton.setAttributedTitle(titleString, for: .normal)
        payButton.layer.cornerRadius = 24.5
        return payButton
    }()

    // MARK: - Functions
    
}

