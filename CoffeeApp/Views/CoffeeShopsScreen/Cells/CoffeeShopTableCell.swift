import UIKit
import SnapKit

final class CoffeeShopTableCell: UITableViewCell {
    // MARK: - Properties
    static let identifier = String.cofeeShopID

    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor(red: 246/255, green: 229/255, blue: 209/255, alpha: 1)
        containerView.layer.cornerRadius = 5.0
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.3
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        return containerView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor(red: 132/255, green: 99/255, blue: 64/255, alpha: 1)
        label.text = "NAME"
        return label
    }()

    private lazy var distanceDifferenceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(red: 175/255, green: 148/255, blue: 121/255, alpha: 1)
        label.text = "1 км от вас"
        return label
    }()

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        layoutForChildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }




    // MARK: - Functions

    private func setupSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(distanceDifferenceLabel)
    }

    private func layoutForChildViews() {

        containerView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.leading.equalTo(contentView.snp.leading).offset(10)
            make.trailing.equalTo(contentView.snp.trailing).offset(-10)
            make.bottom.equalTo(contentView.snp.bottom)
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(14)
            make.leading.equalTo(containerView.snp.leading).offset(10)
            make.trailing.equalTo(containerView.snp.trailing).offset(-86)
            make.height.equalTo(21)
        }

        distanceDifferenceLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(6)
            make.leading.equalTo(containerView.snp.leading).offset(10)
            make.trailing.equalTo(containerView.snp.trailing).offset(-199)
            make.bottom.equalTo(containerView.snp.bottom).offset(-9)
        }
    }

    func updateCellWithData(model: CoffeeShopsModel) {
        nameLabel.text = model.name
        distanceDifferenceLabel.text = model.destinationDifference
        addAttributedTextTo(label: nameLabel)
        addAttributedTextTo(label: distanceDifferenceLabel)
    }

    private func addAttributedTextTo(label: UILabel) {
        if label == nameLabel {
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor(red: 132/255, green: 99/255, blue: 64/255, alpha: 1),
                .kern : -0.12,
                .font : UIFont.systemFont(ofSize: 18, weight: .bold)
            ]
            let attributedText = NSMutableAttributedString(string: label.text!)
            attributedText.addAttributes(attributes, range: NSRange(location: 0, length: label.text!.count))
            nameLabel.attributedText = attributedText
        }

        if label == distanceDifferenceLabel {
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor(red: 132/255, green: 99/255, blue: 64/255, alpha: 1),
                .kern : -0.14,
                .font : UIFont.systemFont(ofSize: 14, weight: .regular)
            ]
            let attributedText = NSMutableAttributedString(string: "\(label.text ?? "0") км от вас")
            attributedText.addAttributes(attributes, range: NSRange(location: 0, length: attributedText.length))
            distanceDifferenceLabel.attributedText = attributedText
        }
    }

}

extension String {
    
    static var cofeeShopID: String {
        return "CoffeShopTableCell"
    }

    static var menuCellID: String {
        return "MenuCollectionCell"
    }
}
