import Combine

internal struct LoginEnvironment {
    let register:(UserData) -> AnyPublisher<Void, Error>
    let makeHomeScene: () -> Void
    let showTermsAndConditions: () -> Void
}
