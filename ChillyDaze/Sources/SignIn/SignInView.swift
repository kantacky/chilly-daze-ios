import ComposableArchitecture
import _AuthenticationServices_SwiftUI
import SwiftUI

public struct SignInView: View {
    public typealias Reducer = SignInReducer
    private let store: StoreOf<Reducer>
    @StateObject private var viewStore: ViewStoreOf<Reducer>

    public init(store: StoreOf<Reducer>) {
        self.store = store
        self._viewStore = .init(wrappedValue: ViewStore(store, observe: { $0 }))
    }

    public var body: some View {
        SignInWithAppleButton(.signIn) { request in
            request.requestedScopes = [.fullName, .email]
        } onCompletion: { result in
            Task {
                self.viewStore.send(.signInWithAppleResult(Result {
                    switch result {
                    case let .success(authResults):
                        return authResults

                    case let .failure(error):
                        throw error
                    }
                }))
            }
        }
        .signInWithAppleButtonStyle(.black)
        .frame(height: 48)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.chillyYellow))
    }
}

#Preview {
    SignInView(store: Store(
        initialState: SignInView.Reducer.State(),
        reducer: { SignInView.Reducer() }
    ))
}
