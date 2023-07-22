import Combine

internal struct SettingsState {
    let items: [SettingsDataSource] = [
        .categories,
        .syncWithBankAccount,
        .summaryOfSpendings,
        .techSupport
    ]
}

internal enum SettingsEvent {
    case userDidTapItem(Int)
}

internal enum SettingsEffect {
    case nothing
}

internal struct SettingsEnvironment {
    let openTechSupportScene: () -> Void
}

internal enum SettingsReducer {
    static func transform(
        state: SettingsState,
        event: SettingsEvent,
        env: SettingsEnvironment
    ) -> AnyPublisher<SettingsEffect, Never> {
        switch event {
        case let .userDidTapItem(index):
            convert(item: state.items[index], to: env)
            return Just(SettingsEffect.nothing).eraseToAnyPublisher()
            
        }
    }
    
    static func apply(
        state: SettingsState,
        effect: SettingsEffect
    ) -> SettingsState {
        let newState = state
        
        switch effect {
        case .nothing:
            break
        }
        return newState
    }
}

extension SettingsReducer {
    static func convert(item: SettingsDataSource, to env: SettingsEnvironment) -> Void? {
        switch item {
        case .techSupport:
            return env.openTechSupportScene()
            
        default:
            return nil
        }
    }
}
