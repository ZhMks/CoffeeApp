import UIKit
import SnapKit

final class CoffeeShopTableCell: UITableViewCell {
    // MARK: - Properties
    static let identifier = String.cofeeShopID

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .label
        label.text = "NAME"
        return label
    }()

    private lazy var distanceDifferenceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .label
        label.text = "1 км от вас"
        return label
    }()

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        layoutForChildViews()
        contentView.backgroundColor = UIColor(red: 175/255, green: 148/255, blue: 121/255, alpha: 1)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: - Functions

    private func setupSubviews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(distanceDifferenceLabel)
    }

    private func layoutForChildViews() {
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(14)
            make.leading.equalTo(contentView.snp.leading).offset(10)
            make.trailing.equalTo(contentView.snp.trailing).offset(-86)
            make.height.equalTo(21)
        }

        distanceDifferenceLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(6)
            make.leading.equalTo(contentView.snp.leading).offset(10)
            make.trailing.equalTo(contentView.snp.trailing).offset(-199)
            make.bottom.equalTo(contentView.snp.bottom).offset(-5)
        }
    }

}

 extension String {
    static var cofeeShopID: String {
        return "CoffeShopTableCell"
    }
}
