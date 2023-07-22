import UIKit
import Combine

internal class TechSupportViewController: UIViewController {
    var subscriptions = Set<AnyCancellable>()
    
    private let mainView = TechSupportView()
    private let evenSubject = PassthroughSubject<TechSupportEvent, Never>()
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.backgroundColor = .mainColor
        title = "Tech Support"
    }
    
    func bind(_ state: AnyPublisher<TechSupportState, Never>) -> AnyPublisher<TechSupportEvent, Never> {
        
        
        return evenSubject.eraseToAnyPublisher()
    }
}
