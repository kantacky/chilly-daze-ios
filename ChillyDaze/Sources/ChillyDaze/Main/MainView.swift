import Achievement
import ChillMap
import ComposableArchitecture
import Record
import SwiftUI

struct MainView: View {
    typealias Reducer = MainReducer
    private let store: StoreOf<Reducer>
    @StateObject private var viewStore: ViewStoreOf<Reducer>

    init(store: StoreOf<Reducer>) {
        Font.registerCustomFonts()
        self.store = store
        self._viewStore = .init(wrappedValue: ViewStore(store, observe: { $0 }))
    }

    var body: some View {
        VStack(spacing: 0) {
            SwitchStore(self.store.scope(state: \.tab, action: \.self)) { state in
                switch state {
                case .chillMap:
                    CaseLet(
                        /Reducer.State.Tab.chillMap,
                        action: Reducer.Action.chillMap
                    ) { store in
                        ChillMapView(store: store)
                    }

                case .record:
                    CaseLet(
                        /Reducer.State.Tab.record,
                         action: Reducer.Action.record
                    ) { store in
                        RecordView(store: store)
                    }

                case .achievement:
                    CaseLet(
                        /Reducer.State.Tab.achievement,
                         action: Reducer.Action.achievement
                    ) { store in
                        AchievementView(store: store)
                    }
                }
            }
            .frame(maxHeight: .infinity)

            TabBarView(store: self.store)
        }
    }
}

#Preview {
    MainView(store: Store(initialState: MainView.Reducer.State()) {
        MainView.Reducer()
    })
}
