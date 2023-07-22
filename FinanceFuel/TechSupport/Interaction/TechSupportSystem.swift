import Combine

internal struct TechSupportState {
}

internal enum TechSupportEvent {
    case userDidTapSend(String)
}

internal enum TechSupportEffect {
    case nothing
}

internal struct TechSupportEnvironment {
}

internal enum TechSupportReducer {
    static func transform(
        state: TechSupportState,
        event: TechSupportEvent,
        env: TechSupportEnvironment
    ) -> AnyPublisher<TechSupportEffect, Never> {
        switch event {
        case let .userDidTapSend(message):
            return Just(TechSupportEffect.nothing).eraseToAnyPublisher()
            
        }
    }
    
    static func apply(
        state: TechSupportState,
        effect: TechSupportEffect
    ) -> TechSupportState {
        let newState = state
        
        switch effect {
        case .nothing:
            break
        }
        return newState
    }
}
