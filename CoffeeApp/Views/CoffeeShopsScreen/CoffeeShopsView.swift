import UIKit
import SnapKit

protocol ICoffeeShopSelected: AnyObject {
    func didSelectCoffeeShop(_ coffeeShop: Int)
}


final class CoffeeShopsView: UIView {
    // MARK: - Properties

    weak var delegate: ICoffeeShopSelected?

    var data: [CoffeeShopsModel] = []

    private lazy var coffeeShopsTableView: UITableView = {
        let coffeeShopsTableView = UITableView(frame: .zero, style: .plain)
        coffeeShopsTableView.translatesAutoresizingMaskIntoConstraints = false
        coffeeShopsTableView.delegate = self
        coffeeShopsTableView.dataSource = self
        coffeeShopsTableView.register(CoffeeShopTableCell.self, forCellReuseIdentifier: .cofeeShopID)
        coffeeShopsTableView.rowHeight = 71
        coffeeShopsTableView.backgroundColor = .white
        coffeeShopsTableView.separatorStyle = .none
        return coffeeShopsTableView
    }()

    private lazy var onMapButton: UIButton = {
        let onMapButton = UIButton(type: .system)
        onMapButton.translatesAutoresizingMaskIntoConstraints = false
        let titleString = NSMutableAttributedString(string: "На карте")
        let attributes: [NSAttributedString.Key : Any] = [
            .font: UIFont.boldSystemFont(ofSize: 18),
            .foregroundColor: UIColor(red: 246/255, green: 229/255, blue: 209/255, alpha: 1),
            .kern: -0.14
        ]
        titleString.addAttributes(attributes, range: NSRange(location: 0, length: titleString.length))
        onMapButton.setAttributedTitle(titleString, for: .normal)
        onMapButton.backgroundColor = UIColor(red: 52/255, green: 25/255, blue: 26/255, alpha: 1)
        onMapButton.layer.cornerRadius = 24.5
        return onMapButton
    }()

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        addViewsToMainView()
        layoutChildViews()
        backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



    // MARK: - Funcs

    private func addViewsToMainView() {
        self.addSubview(coffeeShopsTableView)
        self.addSubview(onMapButton)
    }

    private func layoutChildViews() {
        coffeeShopsTableView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(self.snp.bottom).offset(-90)
            make.width.equalTo(self.snp.width)
        }

        onMapButton.snp.makeConstraints { make in
            make.top.equalTo(coffeeShopsTableView.snp.bottom).offset(10)
            make.leading.equalTo(self.snp.leading).offset(17)
            make.trailing.equalTo(self.snp.trailing).offset(-18)
            make.height.equalTo(47)
        }
    }

    func updateTableView(data: [CoffeeShopsModel]) {
        self.data = data
        coffeeShopsTableView.reloadData()
    }
}


// MARK: - TableViewDataSource
extension CoffeeShopsView: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: .cofeeShopID, for: indexPath) as? CoffeeShopTableCell else { return UITableViewCell() }
        let data = data[indexPath.section]
        cell.updateCellWithData(model: data)
        cell.selectionStyle = .none
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

// MARK: - TableViewDelegate
extension CoffeeShopsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = data[indexPath.section]
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didSelectCoffeeShop(data.id)
    }


}
