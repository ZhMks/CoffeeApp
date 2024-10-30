import UIKit
import SnapKit


final class CoffeeShopsView: UIView {
    // MARK: - Properties

    var data: [CoffeeShopsModel] = []

    private lazy var coffeeShopsTableView: UITableView = {
        let coffeeShopsTableView = UITableView(frame: .zero, style: .insetGrouped)
        coffeeShopsTableView.translatesAutoresizingMaskIntoConstraints = false
        coffeeShopsTableView.delegate = self
        coffeeShopsTableView.dataSource = self
        coffeeShopsTableView.register(CoffeeShopTableCell.self, forCellReuseIdentifier: .cofeeShopID)
        coffeeShopsTableView.rowHeight = 71
        return coffeeShopsTableView
    }()

    private lazy var onMapButton: UIButton = {
        let onMapButton = UIButton(type: .system)
        onMapButton.translatesAutoresizingMaskIntoConstraints = false
        let titleString = NSMutableAttributedString(string: "На карте")
        let attributes: [NSAttributedString.Key : Any] = [
            .font: UIFont.boldSystemFont(ofSize: 18),
            .foregroundColor: UIColor.systemBackground,
            .kern: 0.14
        ]
        titleString.addAttributes(attributes, range: NSRange(location: 0, length: titleString.length))
        onMapButton.setAttributedTitle(titleString, for: .normal)
        onMapButton.backgroundColor = .systemBrown
        onMapButton.layer.cornerRadius = 24.5
        return onMapButton
    }()

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        addViewsToMainView()
        layoutChildViews()
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
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-100)
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
        print("DataInsideView: \(data)")
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
        return cell

    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        5
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }

}

// MARK: - TableViewDelegate
extension CoffeeShopsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
