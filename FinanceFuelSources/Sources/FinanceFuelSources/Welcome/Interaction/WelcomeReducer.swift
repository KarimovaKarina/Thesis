import Combine

internal enum WelcomeReducer {
    static func transform(
        state: WelcomeState,
        event: WelcomeEvent,
        env: WelcomeEnvironment
    ) -> AnyPublisher<WelcomeEffect, Never> {
        switch event {
        case .userDidTapLogin:
            return Just(env.makeLoginScene())
                .map{ WelcomeEffect.nothing}
                .eraseToAnyPublisher()
            
        case .userDidTapRegister:
            return Just(env.makeRegisterScene())
                .map{ WelcomeEffect.nothing}
                .eraseToAnyPublisher()
        }
    }
    
    static func apply(
        state: WelcomeState,
        effect: WelcomeEffect
    ) -> WelcomeState {
        let newState = state
        
        switch effect {
        case .nothing:
            break
        }
        return newState
    }
}

