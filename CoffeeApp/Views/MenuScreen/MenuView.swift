import SnapKit
import UIKit

final class MenuView: UIView {
    // MARK: - Properties

    private lazy var menuCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let colletcionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        colletcionView.translatesAutoresizingMaskIntoConstraints = false
        colletcionView.backgroundColor = .systemBackground
        colletcionView.delegate = self
        colletcionView.dataSource = self
        colletcionView.register(MenuCollectionCell.self, forCellWithReuseIdentifier: MenuCollectionCell.identifier)
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
        return payButton
    }()

    // MARK: - Lifecycle
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .systemBackground
        initialSetup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions

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

}

// MARK: - CollectionView DataSource

extension MenuView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionCell.identifier, for: indexPath) as? MenuCollectionCell else { return UICollectionViewCell() }
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
