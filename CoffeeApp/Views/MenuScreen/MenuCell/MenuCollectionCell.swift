import UIKit
import SnapKit

final class MenuCollectionCell: UICollectionViewCell {
    // MARK: - Properties

    static let identifier = String.menuCellID

    private lazy var itemImageView: UIImageView = {
        let itemImageView = UIImageView()
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        itemImageView.contentMode = .scaleAspectFill
        itemImageView.backgroundColor = .blue
        return itemImageView
    }()

    private lazy var itemNameLabel: UILabel = {
        let itemNameLabel = UILabel()
        itemNameLabel.translatesAutoresizingMaskIntoConstraints = false
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(red: 175/255, green: 148/255, blue: 121/255, alpha: 1),
            .kern : -0.12,
            .font : UIFont.systemFont(ofSize: 15, weight: .medium)
        ]
        let text = "Капучино"
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttributes(attributes, range: NSRange(location: 0, length: text.count))
        itemNameLabel.attributedText = attributedText
        return itemNameLabel
    }()

    private lazy var itemPriceLabel: UILabel = {
        let itemPriceLabel = UILabel()
        itemPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(red: 132/255, green: 99/255, blue: 64/255, alpha: 1),
            .kern : -0.12,
            .font : UIFont.systemFont(ofSize: 14, weight: .bold)
        ]
        let text = "200 руб"
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttributes(attributes, range: NSRange(location: 0, length: text.count))
        itemPriceLabel.attributedText = attributedText
        return itemPriceLabel
    }()

    private lazy var minusButton: UIButton = {
        let minusButton = UIButton(type: .system)
        minusButton.translatesAutoresizingMaskIntoConstraints = false
        minusButton.setBackgroundImage(UIImage(systemName: "minus"), for: .normal)
        minusButton.tintColor = UIColor(red: 246/255, green: 229/255, blue: 209/255, alpha: 1)
        return minusButton
    }()

    private lazy var plusButton: UIButton = {
        let plusButton = UIButton(type: .system)
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
        plusButton.tintColor = UIColor(red: 246/255, green: 229/255, blue: 209/255, alpha: 1)
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
        let text = "5"
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttributes(attributes, range: NSRange(location: 0, length: text.count))
        numberOfItems.attributedText = attributedText
        return numberOfItems
    }()


    // MARK: -Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions


}

// MARK: - Layout
extension MenuCollectionCell {
    private func setupUI() {
        addChildViews()
        layoutChildSubviews()
    }

    private func addChildViews() {
        contentView.addSubview(itemImageView)
        contentView.addSubview(itemNameLabel)
        contentView.addSubview(itemPriceLabel)
        contentView.addSubview(minusButton)
        contentView.addSubview(numberOfItemsLabel)
        contentView.addSubview(plusButton)
    }

    private func layoutChildSubviews() {

        itemImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
            make.height.equalTo(137)
        }

        itemNameLabel.snp.makeConstraints { make in
            make.top.equalTo(itemImageView.snp.bottom).offset(10)
            make.leading.equalTo(contentView.snp.leading).offset(11)
            make.trailing.equalTo(contentView.snp.trailing).offset(-70)
            make.height.equalTo(18)
        }

        itemPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(itemNameLabel.snp.bottom).offset(12)
            make.leading.equalTo(contentView.snp.leading).offset(11)
            make.trailing.equalTo(contentView.snp.trailing).offset(-84)
            make.height.equalTo(17)
        }

        minusButton.snp.makeConstraints { make in
            make.height.width.equalTo(24)
            make.centerY.equalTo(itemPriceLabel.snp.centerY)
            make.leading.equalTo(contentView.snp.leading).offset(84)
        }

        numberOfItemsLabel.snp.makeConstraints { make in
            make.leading.equalTo(minusButton.snp.trailing).offset(9)
            make.trailing.equalTo(plusButton.snp.leading).offset(-9)
            make.height.equalTo(17)
            make.centerY.equalTo(itemPriceLabel.snp.centerY)
        }

        plusButton.snp.makeConstraints { make in
            make.height.width.equalTo(24)
            make.centerY.equalTo(itemPriceLabel.snp.centerY)
            make.leading.equalTo(numberOfItemsLabel.snp.trailing).offset(9)
        }
    }
}
