import Achievement
import ChillMap
import ComposableArchitecture
import Record
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
//        Button("Sign Out") {
//            self.viewStore.send(.onSignOutButtonTapped)
//        }
        TabView {
            ChillMapView(
                store: self.store.scope(
                    state: \.chillMap,
                    action: Reducer.Action.chillMap
                )
            )
            .tabItem {
                Image(systemName: "house")
            }

            RecordView(
                store: self.store.scope(
                    state: \.record,
                    action: Reducer.Action.record
                )
            )
            .tabItem {
                Image(systemName: "book.pages")
            }

            AchievementView(
                store: self.store.scope(
                    state: \.achievement,
                    action: Reducer.Action.achievement
                )
            )
            .tabItem {
                Image(systemName: "star.circle")
            }
        }
    }
}

#Preview {
    MainView(store: Store(
        initialState: MainView.Reducer.State(),
        reducer: { MainView.Reducer() }
    ))
}
