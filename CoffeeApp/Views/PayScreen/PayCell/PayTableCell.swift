import UIKit
import SnapKit

protocol IPayCellDelegate: AnyObject {
        func removeItem(item: OrderModel)
        func addItem(item: OrderModel)
}

final class PayTableCell: UITableViewCell {

    static let identifier = String.payTableCell
    weak var delegate: IPayCellDelegate?
    var item: OrderModel?

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

    private lazy var itemNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor(red: 132/255, green: 99/255, blue: 64/255, alpha: 1)
        label.text = "NAME"
        return label
    }()

    private lazy var itemPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(red: 175/255, green: 148/255, blue: 121/255, alpha: 1)
        label.text = "200 руб"
        return label
    }()

    private lazy var minusButton: UIButton = {
        let minusButton = UIButton(type: .system)
        minusButton.translatesAutoresizingMaskIntoConstraints = false
        minusButton.setBackgroundImage(UIImage(systemName: "minus"), for: .normal)
        minusButton.tintColor = UIColor(red: 132/255, green: 99/255, blue: 64/255, alpha: 1)
        minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        return minusButton
    }()

    private lazy var plusButton: UIButton = {
        let plusButton = UIButton(type: .system)
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.setImage(UIImage(named: "plus"), for: .normal)
        plusButton.tintColor = UIColor(red: 132/255, green: 99/255, blue: 64/255, alpha: 1)
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        return plusButton
    }()

    private lazy var numberOfItemsLabel: UILabel = {
        let numberOfItems = UILabel()
        numberOfItems.translatesAutoresizingMaskIntoConstraints = false
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(red: 132/255, green: 99/255, blue: 64/255, alpha: 1),
            .kern : -0.12,
            .font : UIFont.systemFont(ofSize: 14, weight: .regular)
        ]
        let text = numberOfItems.text ?? "0"
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttributes(attributes, range: NSRange(location: 0, length: text.count))
        numberOfItems.attributedText = attributedText
        return numberOfItems
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

    @objc func minusButtonTapped() {
        guard let item = self.item else { return }
        delegate?.removeItem(item: item)
    }

    @objc func plusButtonTapped() {
        guard let item = self.item else { return }
        delegate?.addItem(item: item)
    }

    func updateCellWithData(model: OrderModel) {
        self.item = model
        itemNameLabel.text = model.name
        itemPriceLabel.text = String(model.price)
        addAttributedTextTo(label: itemNameLabel)
        addAttributedTextTo(label: itemPriceLabel)
        numberOfItemsLabel.text = "\(model.totalNumberOfItem)"
    }

    private func setupSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(itemNameLabel)
        containerView.addSubview(itemPriceLabel)
        containerView.addSubview(minusButton)
        containerView.addSubview(numberOfItemsLabel)
        containerView.addSubview(plusButton)
    }

    private func layoutForChildViews() {

        containerView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.leading.equalTo(contentView.snp.leading).offset(10)
            make.trailing.equalTo(contentView.snp.trailing).offset(-10)
            make.bottom.equalTo(contentView.snp.bottom)
        }

        itemNameLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(14)
            make.leading.equalTo(containerView.snp.leading).offset(10)
            make.trailing.equalTo(containerView.snp.trailing).offset(-86)
            make.height.equalTo(21)
        }

        itemPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(itemNameLabel.snp.bottom).offset(6)
            make.leading.equalTo(containerView.snp.leading).offset(10)
            make.trailing.equalTo(containerView.snp.trailing).offset(-199)
            make.bottom.equalTo(containerView.snp.bottom).offset(-9)
        }

        minusButton.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(24)
            make.width.equalTo(24)
            make.leading.equalTo(containerView.snp.leading).offset(295)
            make.bottom.equalTo(containerView.snp.bottom).offset(-23)
        }

        numberOfItemsLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.centerY.equalTo(minusButton.snp.centerY)
            make.trailing.equalTo(plusButton.snp.leading).offset(-9)
            make.leading.equalTo(minusButton.snp.trailing).offset(9)
        }

        plusButton.snp.makeConstraints { make in
            make.width.equalTo(24)
            make.top.equalTo(containerView.snp.top).offset(24)
            make.leading.equalTo(containerView.snp.leading).offset(345)
            make.bottom.equalTo(containerView.snp.bottom).offset(-23)
        }
    }

    private func addAttributedTextTo(label: UILabel) {
        if label == itemNameLabel {
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor(red: 132/255, green: 99/255, blue: 64/255, alpha: 1),
                .kern : -0.12,
                .font : UIFont.systemFont(ofSize: 18, weight: .bold)
            ]
            let attributedText = NSMutableAttributedString(string: label.text!)
            attributedText.addAttributes(attributes, range: NSRange(location: 0, length: label.text!.count))
            itemNameLabel.attributedText = attributedText
        }

        if label == itemPriceLabel {
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor(red: 132/255, green: 99/255, blue: 64/255, alpha: 1),
                .kern : -0.14,
                .font : UIFont.systemFont(ofSize: 16, weight: .medium)
            ]
            let attributedText = NSMutableAttributedString(string: "\(label.text ?? "0") руб")
            attributedText.addAttributes(attributes, range: NSRange(location: 0, length: attributedText.length))
            itemPriceLabel.attributedText = attributedText
        }
    }
}

extension String {
    static let payTableCell = "PayTableCell"
}
