import Combine

internal enum LoginReducer {
    static func transform(
        state: LoginState,
        event: LoginEvent,
        env: LoginEnvironment
    ) -> AnyPublisher<LoginEffect, Never> {
        switch event {
        case .userDidTapLogin:
            return Just(env.makeHomeScene())
                .map{ LoginEffect.nothing }
                .eraseToAnyPublisher()
            
        case let .userDidTapRegister((email, password)):
            guard let email = email else {
                return Just(LoginEffect.emailError).eraseToAnyPublisher()
            }
            
            guard let password = password else {
                return Just(LoginEffect.passwordError).eraseToAnyPublisher()
            }
            
            return env.register(.init(email: email, password: password))
                .flatMap { Just(env.makeHomeScene())
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                }
                .map{ LoginEffect.nothing }
                .catch { Just(LoginEffect.errorOccured($0)) }
                .eraseToAnyPublisher()
            
        case .userDidTapTermsAndConditions:
            return Just(env.showTermsAndConditions())
                .map{ LoginEffect.nothing }
                .eraseToAnyPublisher()
        }
    }
    
    static func apply(
        state: LoginState,
        effect: LoginEffect
    ) -> LoginState {
        var newState = state
        newState.error = nil
        newState.emailError = nil
        newState.password = nil

        switch effect {
        case .nothing:
            break
            
        case let .errorOccured(error):
            newState.error = error
            
        case .emailError:
            newState.emailError = "Is Empty"
            
        case .passwordError:
            newState.passwordError = "Is Empty"
        }
        return newState
    }
}
