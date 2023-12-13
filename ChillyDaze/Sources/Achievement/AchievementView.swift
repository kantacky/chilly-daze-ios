import ComposableArchitecture
import NukeUI
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
                        switch self.viewStore.user {
                        case .initialized:
                            EmptyView()

                        case .loading:
                            ProgressView()
                                .frame(maxWidth: .infinity)

                        case let .loaded(user):
                            LazyImage(url: user.avatar) { state in
                                if let image = state.image {
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .clipShape(Circle())
                                } else if state.error != nil {
                                    Circle()
                                        .fill(Color.gray)
                                        .frame(width: 100, height: 100)
                                } else {
                                    Circle()
                                        .fill(Color.gray)
                                        .frame(width: 100, height: 100)
                                }
                            }

                            Text(user.name)
                                .font(Font.customFont(.inikaRegular, size: 20))
                                .tint(Color.chillyBlack)
                        }
                    }

                    switch self.viewStore.userAchievements {
                    case .initialized:
                        EmptyView()

                    case .loading:
                        ProgressView()
                            .frame(maxWidth: .infinity)

                    case let .loaded(userAchievements):
                        if userAchievements.isEmpty {
                            Text("No Achievements")
                        } else {
                            ScrollView(.horizontal) {
                                ForEach(userAchievements) { achievement in
                                    Text(achievement.name)
                                }
                            }
                        }
                    }
                }
            }
            .refreshable {
                self.viewStore.send(.onRefresh)
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.chillyWhite)
        .onAppear {
            self.viewStore.send(.onAppear)
        }
        .alert(store: self.store.scope(state: \.$alert, action: Reducer.Action.alert))
        .fullScreenCover(store: self.store.scope(state: \.$settings, action: Reducer.Action.settings)) { store in
            SettingsView(store: store)
        }
    }
}

#Preview {
    AchievementView(store: Store(
        initialState: AchievementView.Reducer.State(),
        reducer: { AchievementView.Reducer() },
        withDependencies: { $0.gatewayClient = .previewValue }
    ))
}
