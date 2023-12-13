import ComposableArchitecture
import Resources
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
                .fill(Color.chillyBlack)
                .frame(height: 2)

            HStack {
                Spacer()

                Button {
                    self.viewStore.send(.onTabButtonTapped(.chillMap(.init())))
                } label: {
                    if case .chillMap = self.viewStore.state.self {
                        Image(systemName: "house.fill")
                    } else {
                        Image(systemName: "house")
                    }
                }

                Spacer()

                Button {
                    self.viewStore.send(.onTabButtonTapped(.record(.init())))
                } label: {
                    if case .record = self.viewStore.state.self {
                        Image(systemName: "book.pages.fill")
                    } else {
                        Image(systemName: "book.pages")
                    }
                }

                Spacer()

                Button {
                    self.viewStore.send(.onTabButtonTapped(.achievement(.init())))
                } label: {
                    if case .achievement = self.viewStore.state.self {
                        Image(systemName: "star.circle.fill")
                    } else {
                        Image(systemName: "star.circle")
                    }
                }

                Spacer()
            }
            .font(.system(size: 24))
            .tint(Color.chillyBlack)
            .padding(.vertical, 19)
            .background(Color.chillyWhite)
        }
    }
}

#Preview {
    TabBarView(store: Store(
        initialState: MainView.Reducer.State(),
        reducer: { MainView.Reducer() }
    ))
}
