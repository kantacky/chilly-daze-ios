import ComposableArchitecture
import SwiftUI

public struct MainView: View {
    public typealias Reducer = MainReducer
    private let store: StoreOf<Reducer>
    @StateObject private var viewStore: ViewStoreOf<Reducer>

    public init(store: StoreOf<Reducer>) {
        self.store = store
        self._viewStore = .init(wrappedValue: ViewStore(store, observe: { $0 }))
    }

    public var body: some View {
        Button("Sign Out") {
            self.viewStore.send(.onSignOutButtonTapped)
        }
    }
}

#Preview {
    MainView(store: Store(
        initialState: MainView.Reducer.State(),
        reducer: { MainView.Reducer() }
    ))
}
