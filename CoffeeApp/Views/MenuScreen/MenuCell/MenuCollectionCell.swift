import UIKit
import SnapKit
import Kingfisher

protocol ICreateOrder: AnyObject {
    func addToCart(_ item: OrderModel)
    func removeFromCart(_ item: OrderModel)
}

final class MenuCollectionCell: UICollectionViewCell {
    // MARK: - Properties

    static let identifier = String.menuCellID
    private var itemsCount = 0
    private var menuItem: MenuItemModel?
    weak var delegate: ICreateOrder?
    private var orderModel = OrderModel(id: 0, name: "", price: 0, totalNumberOfItem: 0)

    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 5.0
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.3
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        return containerView
    }()

    private lazy var itemImageView: UIImageView = {
        let itemImageView = UIImageView()
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        itemImageView.contentMode = .scaleAspectFill
        itemImageView.backgroundColor = .white
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
        let text = itemNameLabel.text ?? "Test Name"
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
        let text = itemPriceLabel.text ?? "0"
        let attributedText = NSMutableAttributedString(string: "\(text)руб")
        attributedText.addAttributes(attributes, range: NSRange(location: 0, length: text.count))
        itemPriceLabel.attributedText = attributedText
        return itemPriceLabel
    }()

    private lazy var minusButton: UIButton = {
        let minusButton = UIButton(type: .system)
        minusButton.translatesAutoresizingMaskIntoConstraints = false
        minusButton.setBackgroundImage(UIImage(systemName: "minus"), for: .normal)
        minusButton.tintColor = UIColor(red: 246/255, green: 229/255, blue: 209/255, alpha: 1)
        minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        return minusButton
    }()

    private lazy var plusButton: UIButton = {
        let plusButton = UIButton(type: .system)
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
        plusButton.tintColor = UIColor(red: 246/255, green: 229/255, blue: 209/255, alpha: 1)
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


    // MARK: -Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions
    func updateCellWithData(data: MenuItemModel) {
        self.menuItem = data
        if let imageUrl = data.image, let url = URL(string: imageUrl) {
            itemImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "checkmark")) { [weak self] result in
                switch result {
                case .success(let retrivedimage):
                    self?.itemImageView.image = retrivedimage.image
                case .failure(let failuer):
                    print(failuer.localizedDescription)
                }
            }
        } else {
            itemImageView.image = UIImage(systemName: "cup.and.saucer")
        }

        itemNameLabel.text = data.name
        itemPriceLabel.text = String(data.price)
    }

    @objc func plusButtonTapped() {
        itemsCount += 1
        numberOfItemsLabel.text = "\(itemsCount)"
        orderModel.id = menuItem!.id
        orderModel.name = menuItem!.name
        orderModel.price = menuItem!.price
        orderModel.totalNumberOfItem = itemsCount
        delegate?.addToCart(orderModel)
    }

    @objc func minusButtonTapped() {
        if itemsCount < 0 {
            return
        } else {
            itemsCount -= 1
            numberOfItemsLabel.text = "\(itemsCount)"
            orderModel.totalNumberOfItem = itemsCount
            delegate?.removeFromCart(orderModel)
        }
    }

}

// MARK: - Layout
extension MenuCollectionCell {
    private func setupUI() {
        addChildViews()
        layoutChildSubviews()
    }

    private func addChildViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(itemImageView)
        containerView.addSubview(itemNameLabel)
        containerView.addSubview(itemPriceLabel)
        containerView.addSubview(minusButton)
        containerView.addSubview(numberOfItemsLabel)
        containerView.addSubview(plusButton)
    }

    private func layoutChildSubviews() {

        containerView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
            make.bottom.equalTo(contentView.snp.bottom)
        }
        itemImageView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top)
            make.leading.equalTo(containerView.snp.leading)
            make.trailing.equalTo(containerView.snp.trailing)
            make.height.equalTo(137)
        }

        itemNameLabel.snp.makeConstraints { make in
            make.top.equalTo(itemImageView.snp.bottom).offset(10)
            make.leading.equalTo(containerView.snp.leading).offset(11)
            make.trailing.equalTo(containerView.snp.trailing).offset(-20)
            make.height.equalTo(18)
        }

        itemPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(itemNameLabel.snp.bottom).offset(12)
            make.leading.equalTo(containerView.snp.leading).offset(11)
            make.trailing.equalTo(containerView.snp.trailing).offset(-84)
            make.height.equalTo(17)
        }

        minusButton.snp.makeConstraints { make in
            make.height.width.equalTo(24)
            make.centerY.equalTo(itemPriceLabel.snp.centerY)
            make.leading.equalTo(containerView.snp.leading).offset(84)
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
