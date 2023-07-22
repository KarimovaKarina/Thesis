import Combine

internal enum LoginReducer {
    static func transform(
        state: LoginState,
        event: LoginEvent,
        env: LoginEnvironment
    ) -> AnyPublisher<LoginEffect, Never> {
        switch event {
        case .userDidTapLogin:
            return Just(env.makeHomeScene()).map{ LoginEffect.nothing }.eraseToAnyPublisher()
            
        case .userDidTapRegister:
            return Just(env.makeHomeScene()).map{ LoginEffect.nothing }.eraseToAnyPublisher()
        }
    }
    
    static func apply(
        state: LoginState,
        effect: LoginEffect
    ) -> LoginState {
        let newState = state
        
        switch effect {
        case .nothing:
            break
        }
        return newState
    }
}
