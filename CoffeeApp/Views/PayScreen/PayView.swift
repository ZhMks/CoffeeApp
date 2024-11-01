import SnapKit
import UIKit

protocol IPayDelegate: AnyObject {
    func removeItem(item: OrderModel)
    func addItem(item: OrderModel)
}

final class PayView: UIView {

    weak var delegate: IPayDelegate?

    var orderData: [OrderModel] = []

    // MARK: - Properties
    private lazy var payOrderTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PayTableCell.self, forCellReuseIdentifier: PayTableCell.identifier)
        tableView.rowHeight = 71
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
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
        let text = "Время ожидания заказа\n15 минут!\nСпасибо, что выбрали нас!"
        informationLabel.textAlignment = .center
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttributes(attributes, range: NSRange(location: 0, length: attributedText.length))
        informationLabel.attributedText = attributedText
        informationLabel.numberOfLines = 0 
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

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions
    func updateDataForView(order: [OrderModel]) {
        self.orderData = order
        payOrderTableView.reloadData()
    }
}

// MARK: - Layout
extension PayView {
    private func setupUI() {
        self.addSubview(payOrderTableView)
        self.addSubview(informationLabel)
        self.addSubview(payButton)
    }

    private func setupConstraints() {
        payOrderTableView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing)
            make.width.equalTo(self.snp.width)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-300)
        }

        informationLabel.snp.makeConstraints { make in
            make.top.equalTo(payOrderTableView.snp.bottom).offset(10)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(13)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-13)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-106)
        }

        payButton.snp.makeConstraints { make in
            make.top.equalTo(informationLabel.snp.bottom).offset(30)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(10)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-10)
            make.height.equalTo(48)
        }
    }
}

// MARK: - TableView DataSource
extension PayView: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        orderData.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PayTableCell.identifier, for: indexPath) as? PayTableCell else { return UITableViewCell() }
        let dataForCell = orderData[indexPath.section]
        cell.updateCellWithData(model: dataForCell)
        cell.selectionStyle = .none
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        10
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }


}

// MARK: - TableView Delegate
extension PayView: UITableViewDelegate {

}

// MARK: - IPAYCell delegate
extension PayView: IPayCellDelegate {
    func removeItem(item: OrderModel) {
        delegate?.removeItem(item: item)
    }
    
    func addItem(item: OrderModel) {
        delegate?.addItem(item: item)
    }
    

}
