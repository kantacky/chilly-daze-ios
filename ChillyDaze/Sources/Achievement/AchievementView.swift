import ComposableArchitecture
import Resources
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
        VStack {
            HStack {
                Spacer()

                Button {
                    self.viewStore.send(.onSettingsButtonTapped)
                } label: {
                    Image(systemName: "gearshape")
                        .tint(Color.chillyBlack)
                        .font(.system(size: 20))
                }
            }

            ScrollView {
                VStack(spacing: 36) {
                    VStack(spacing: 16) {
                        Circle()
                            .fill(Color.gray)
                            .frame(width: 100, height: 100)

                        Text("username")
                            .font(Font.customFont(.inikaRegular, size: 20))
                    }

                    VStack {
                        HStack(spacing: 24) {
                            Rectangle()
                                .fill(Color.gray)
                                .frame(
                                    width: (UIScreen.main.bounds.width - 72) / 2,
                                    height: (UIScreen.main.bounds.width - 72) / 2
                                )

                            Rectangle()
                                .fill(Color.gray)
                                .frame(
                                    width: (UIScreen.main.bounds.width - 72) / 2,
                                    height: (UIScreen.main.bounds.width - 72) / 2
                                )
                        }
                    }
                }
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.chillyWhite)
        .sheet(store: self.store.scope(state: \.$settings, action: Reducer.Action.settings)) { store in
            SettingsView(store: store)
        }
    }
}

#Preview {
    AchievementView(store: Store(
        initialState: AchievementView.Reducer.State(),
        reducer: { AchievementView.Reducer() }
    ))
}
