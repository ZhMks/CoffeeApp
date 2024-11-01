import SnapKit
import UIKit

protocol IPayMenuInteraction: AnyObject {
    func goToPayment()
    func addToCart(item: OrderModel)
    func removeFromCart(item: OrderModel)
}

final class MenuView: UIView {
    // MARK: - Properties

    var dataForcell: [MenuItemModel] = []
    weak var delegate: IPayMenuInteraction?

    private lazy var menuCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let colletcionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        colletcionView.translatesAutoresizingMaskIntoConstraints = false
        colletcionView.backgroundColor = .white
        colletcionView.delegate = self
        colletcionView.dataSource = self
        colletcionView.register(MenuCollectionCell.self, forCellWithReuseIdentifier: MenuCollectionCell.identifier)
        colletcionView.isScrollEnabled = true
        return colletcionView
    }()

    private lazy var payButton: UIButton = {
        let payButton = UIButton(type: .system)
        payButton.translatesAutoresizingMaskIntoConstraints = false
        payButton.backgroundColor = UIColor(red: 52/255, green: 25/255, blue: 26/255, alpha: 1)
        let titleString = NSMutableAttributedString(string: "Перейти к оплате")
        let attributes: [NSAttributedString.Key : Any] = [
            .font: UIFont.boldSystemFont(ofSize: 18),
            .foregroundColor: UIColor(red: 246/255, green: 229/255, blue: 209/255, alpha: 1),
            .kern: -0.14
        ]
        titleString.addAttributes(attributes, range: NSRange(location: 0, length: titleString.length))
        payButton.setAttributedTitle(titleString, for: .normal)
        payButton.layer.cornerRadius = 24.5
        payButton.addTarget(self, action: #selector(goToPayScreen), for: .touchUpInside)
        return payButton
    }()

    // MARK: - Lifecycle
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        initialSetup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions

    @objc func goToPayScreen() {
        delegate?.goToPayment()
    }

    private func initialSetup() {
        addChildViews()
        layotChildViews()
    }

    private func addChildViews() {
        addSubview(menuCollectionView)
        addSubview(payButton)
    }

    private func layotChildViews() {
        menuCollectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-90)
        }

        payButton.snp.makeConstraints { make in
            make.top.equalTo(menuCollectionView.snp.bottom).offset(10)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-10)
            make.height.equalTo(47)
        }
    }

    func updateDataForCollectionView(data: [MenuItemModel]) {
        self.dataForcell = data
        menuCollectionView.reloadData()
    }
}

// MARK: - CollectionView DataSource

extension MenuView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataForcell.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionCell.identifier, for: indexPath) as? MenuCollectionCell else { return UICollectionViewCell() }
        let data = dataForcell[indexPath.row]
        cell.updateCellWithData(data: data)
        cell.delegate = self
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 13, bottom: 13, right: 13)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 165, height: 205)
    }

}

// MARK: - CollectionView delegate
extension MenuView: UICollectionViewDelegateFlowLayout {

}

// MARK: - ICreate order delegate
extension MenuView: ICreateOrder {
    
    func addToCart(_ item: OrderModel) {
        delegate?.addToCart(item: item)
    }
    
    func removeFromCart(_ item: OrderModel) {
        delegate?.removeFromCart(item: item)
    }
}
