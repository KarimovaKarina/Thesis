import UIKit
import Combine

internal final class SettingsView: UIView {
    var didTapRow: AnyPublisher<Int, Never> {
        selectedRowSubject.eraseToAnyPublisher()
    }
    
    private let tableView = UITableView()
    private var dataSource: [SettingsDataSource] = []
    private let selectedRowSubject = PassthroughSubject<Int,Never>()

    init() {
        super.init(frame: .zero)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        tableView.dataSource = self
        tableView.delegate = self

        tableView.registerReusableCell(SettingsTableViewCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
    }
    
    private func layout() {
        addSubview(tableView)
        tableView.constrain(.all, to: self)
    }
     
    func update(dataSource: [SettingsDataSource]) {
        self.dataSource = dataSource
        tableView.reloadData()
    }
}

extension SettingsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SettingsTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.update(text: dataSource[indexPath.row].rawValue)
        return cell
    }
    
    
}

extension SettingsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRowSubject.send(indexPath.row)
    }
}
