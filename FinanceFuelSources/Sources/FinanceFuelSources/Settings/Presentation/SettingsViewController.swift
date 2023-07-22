import UIKit
import Combine

internal final class SettingsViewController: UIViewController {
    var subscriptions = Set<AnyCancellable>()
    
    private let mainView = SettingsView()
    private let evenSubject = PassthroughSubject<SettingsEvent, Never>()

    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    func bind(_ state: AnyPublisher<SettingsState, Never>) -> AnyPublisher<SettingsEvent, Never> {
        state
            .map(\.items)
            .sink(receiveValue: { [mainView] in mainView.update(dataSource: $0) })
            .store(in: &subscriptions)
        
        mainView.didTapRow
            .sink(receiveValue: {[evenSubject] in evenSubject.send(.userDidTapItem($0))})
            .store(in: &subscriptions)
        
        return evenSubject.eraseToAnyPublisher()
    }
}
