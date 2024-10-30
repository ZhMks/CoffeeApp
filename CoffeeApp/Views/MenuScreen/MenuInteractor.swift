protocol IMenuInteractor: AnyObject {
 init (dataSource: IDataSourceService, id: Int)
    func fetchMenuForShop()
}

protocol IMenuInteractorOutput: AnyObject {
}

final class MenuInteractor: IMenuInteractor {

    // MARK: - Properties
    weak var output: IMenuInteractorOutput?

    private let dataSource: IDataSourceService
    private let id: Int

    // MARK: - Lifecycle
    init (dataSource: IDataSourceService, id: Int) {
        self.dataSource = dataSource
        self.id = id
    }

    // MARK: - Functions
    func fetchMenuForShop() {
        print()
    }
}
