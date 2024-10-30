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
        itemNameLabel.text = "ItemNameLabel"
        return itemNameLabel
    }()

    private lazy var itemPriceLabel: UILabel = {
        let itemPriceLabel = UILabel()
        itemPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        itemPriceLabel.text = "ItemPriceLabel"
        return itemPriceLabel
    }()

    private lazy var minusButton: UIButton = {
        let minusButton = UIButton(type: .system)
        minusButton.translatesAutoresizingMaskIntoConstraints = false
        minusButton.backgroundColor = .black
        return minusButton
    }()

    private lazy var plusButton: UIButton = {
        let plusButton = UIButton(type: .system)
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.backgroundColor = .black
        return plusButton
    }()

    private lazy var numberOfItemsLabel: UILabel = {
        let numberOfItems = UILabel()
        numberOfItems.translatesAutoresizingMaskIntoConstraints = false
        numberOfItems.text = "5"
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

//        minusButton.snp.makeConstraints { make in
//            make.leading.equalTo(itemPriceLabel.snp.trailing).offset(10)
//            make.centerY.equalTo(itemPriceLabel.snp.centerY)
//            make.trailing.equalTo(contentView.snp.trailing).offset(-19)
//            make.height.equalTo(4)
//        }
//
//        numberOfItemsLabel.snp.makeConstraints { make in
//            make.leading.equalTo(minusButton.snp.trailing).offset(9)
//            make.trailing.equalTo(plusButton.snp.leading).offset(-9)
//            make.height.equalTo(17)
//            make.centerY.equalTo(itemPriceLabel.snp.centerY)
//        }
//
//        minusButton.snp.makeConstraints { make in
//            make.leading.equalTo(numberOfItemsLabel.snp.trailing).offset(9)
//            make.centerY.equalTo(itemPriceLabel.snp.centerY)
//            make.trailing.equalTo(contentView.snp.trailing).offset(-6)
//            make.height.equalTo(4)
//        }
    }
}
