import UIKit
import SnapKit

final class MapVC: UIViewController {

    // MARK: - Properties
    private let mapView = MapView()
    private let presenter: IMapPresenter

    // MARK: - Lifecycle

    init(presenter: IMapPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        layoutUI()
        setupNavigationBar()
        presenter.viewDidLoad(view: self)
        presenter.updateData()
    }

    // MARK: - Functions

    private func setupUI() {
        view.addSubview(mapView)
    }

    private func layoutUI() {
        mapView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func setupNavigationBar() {
        let navigationView = UIView()
        let titleLabel = UILabel()
        let title = "Карта"
        let characterSpacing = -0.12
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 18),
            .foregroundColor: UIColor.systemBrown,
            .kern: characterSpacing
        ]

        let attributedTitle = NSMutableAttributedString(string: title, attributes: attributes)

        titleLabel.attributedText = attributedTitle
        titleLabel.sizeToFit()
        titleLabel.center = navigationView.center
        navigationView.addSubview(titleLabel)

        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 24))
        let leftButton = UIButton(frame: CGRect(x: 6, y: 6, width: 8, height: 12))
        leftButton.setBackgroundImage(UIImage(named: "chevron.left"), for: .normal)
        leftView.addSubview(leftButton)
        leftButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        leftButton.tintColor = .systemBrown

        let leftBarButton = UIBarButtonItem(customView: leftView)
        self.navigationItem.leftBarButtonItem = leftBarButton
        self.navigationItem.titleView = navigationView
    }

   @objc private func dismissView() {
       presenter.dimsiss()
    }
}

// MARK: - Presenter output

extension MapVC: IMapView {
    func updateData(data: [CoffeeShopsModel]) {
        mapView.updateDataForView(data: data)
    }
    
    
}
