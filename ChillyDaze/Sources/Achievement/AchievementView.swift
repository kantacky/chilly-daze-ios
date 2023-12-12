import ComposableArchitecture
import SwiftUI

public struct AchievementView: View {
    public typealias Reducer = AchievementReducer
    private let store: StoreOf<Reducer>
    @StateObject private var viewStore: ViewStoreOf<Reducer>

    public init(store: StoreOf<Reducer>) {
        self.store = store
        self._viewStore = .init(wrappedValue: ViewStore(store, observe: { $0 }))
    }

    public var body: some View {
        Button {

        } label: {
            Image(systemName: "gearshape")
        }
    }
}

#Preview {
    AchievementView(store: Store(
        initialState: AchievementView.Reducer.State(),
        reducer: { AchievementView.Reducer() }
    ))
}
