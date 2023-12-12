import ComposableArchitecture
import SwiftUI

struct TabBarView: View {
    typealias Reducer = MainReducer
    private let store: StoreOf<Reducer>
    @StateObject private var viewStore: ViewStoreOf<Reducer>

    public init(store: StoreOf<Reducer>) {
        self.store = store
        self._viewStore = .init(
            wrappedValue: ViewStore(store, observe: { $0 })
        )
    }

    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .frame(height: 2)
                .background(Color(.chillyBlack))

            HStack {
                Spacer()
                ForEach(Reducer.State.allCases) { tab in
                    Button {
                        self.viewStore.send(.onTabButtonTapped(tab))
                    } label: {
                        tab.tabImage(isSelected: self.viewStore.state == tab)
                    }
                    Spacer()
                }
            }
            .font(.system(size: 24))
            .tint(Color(.chillyBlack))
            .padding(.vertical, 24)
            .background(Color(.chillyWhite))
        }
    }
}

#Preview {
    TabBarView(store: Store(
        initialState: MainView.Reducer.State(),
        reducer: { MainView.Reducer() }
    ))
}
