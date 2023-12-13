import ComposableArchitecture
import NukeUI
import Resources
import SwiftUI

public struct AchievementView: View {
    public typealias Reducer = AchievementReducer
    private let store: StoreOf<Reducer>
    @StateObject private var viewStore: ViewStoreOf<Reducer>

    public init(store: StoreOf<Reducer>) {
        Font.registerCustomFonts()
        self.store = store
        self._viewStore = .init(wrappedValue: ViewStore(store, observe: { $0 }))
    }

    public var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()

                Button {
                    self.viewStore.send(.onSettingsButtonTapped)
                } label: {
                    Image(systemName: "gearshape")
                        .tint(Color.chillyBlack)
                        .font(.system(size: 24))
                }
            }

            ScrollView {
                VStack(spacing: 24) {
                    VStack(spacing: 16) {
                        switch self.viewStore.user {
                        case .initialized, .loading:
                            Circle()
                                .stroke(Color.chillyBlack, style: StrokeStyle(lineWidth: 2))
                                .fill(Color.chillyWhite)
                                .frame(width: 72, height: 72)

                            Rectangle()
                                .fill(Color.chillyBlack)
                                .frame(width: 96, height: 28)

                        case let .loaded(user):
                            LazyImage(url: user.avatar) { state in
                                if let image = state.image {
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 72, height: 72)
                                        .clipShape(Circle())
                                        .overlay {
                                            Circle()
                                                .stroke(Color.chillyBlack, style: StrokeStyle(lineWidth: 2))
                                        }
                                } else if state.error != nil {
                                    Circle()
                                        .stroke(Color.chillyBlack, style: StrokeStyle(lineWidth: 2))
                                        .fill(Color.chillyWhite)
                                        .frame(width: 72, height: 72)
                                } else {
                                    Circle()
                                        .stroke(Color.chillyBlack, style: StrokeStyle(lineWidth: 2))
                                        .fill(Color.chillyWhite)
                                        .frame(width: 72, height: 72)
                                }
                            }

                            ZStack {
                                Rectangle()
                                    .fill(Color.clear)
                                    .frame(width: 96, height: 28)

                                Text(user.name)
                                    .font(Font.customFont(.inikaRegular, size: 20))
                                    .tint(Color.chillyBlack)
                            }
                        }
                    }

                    Divider()
                        .frame(height: 2)
                        .background(Color.chillyBlack)


                    VStack(alignment: .leading, spacing: 24) {
                        VStack(alignment: .leading, spacing: 14) {
                            Text("面積")
                                .font(Font.customFont(.zenKakuGothicAntiqueMedium, size: 20))
                            ScrollView(.horizontal) {
                                switch self.viewStore.userAchievements {
                                case .initialized, .loading:
                                    HStack {
                                        Rectangle()
                                            .fill(Color.chillyBlack)
                                            .frame(width: 100, height: 100)
                                        Rectangle()
                                            .fill(Color.chillyBlack)
                                            .frame(width: 100, height: 100)
                                        Rectangle()
                                            .fill(Color.chillyBlack)
                                            .frame(width: 100, height: 100)
                                        Rectangle()
                                            .fill(Color.chillyBlack)
                                            .frame(width: 100, height: 100)
                                    }

                                case let .loaded(userAchievements):
                                    HStack {
                                        ForEach(userAchievements.filter { $0.category == "面積" } ) { achievement in
                                            if let url = achievement.image {
                                                LazyImage(url: url) { state in
                                                    if let image = state.image {
                                                        image
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: 96, height: 96)
                                                            .clipShape(Circle())
                                                            .overlay {
                                                                Circle()
                                                                    .stroke(Color.chillyBlack, style: StrokeStyle(lineWidth: 2))
                                                            }
                                                    } else if state.error != nil {
                                                        Circle()
                                                            .stroke(Color.chillyBlack, style: StrokeStyle(lineWidth: 2))
                                                            .fill(Color.chillyWhite)
                                                            .frame(width: 96, height: 96)
                                                    } else {
                                                        Circle()
                                                            .stroke(Color.chillyBlack, style: StrokeStyle(lineWidth: 2))
                                                            .fill(Color.chillyWhite)
                                                            .frame(width: 96, height: 96)
                                                    }
                                                }
                                            } else {
                                                Image.achievementDefault
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 96, height: 96)
                                                    .clipShape(Circle())
                                                    .overlay {
                                                        Circle()
                                                            .stroke(Color.chillyBlack, style: StrokeStyle(lineWidth: 2))
                                                    }
                                            }
                                        }
                                    }
                                    .padding(4)
                                }
                            }
                        }

                        VStack(alignment: .leading, spacing: 14) {
                            Text("回数")
                                .font(Font.customFont(.zenKakuGothicAntiqueMedium, size: 20))
                            ScrollView(.horizontal) {
                                switch self.viewStore.userAchievements {
                                case .initialized, .loading:
                                    HStack {
                                        Rectangle()
                                            .fill(Color.chillyBlack)
                                            .frame(width: 100, height: 100)
                                        Rectangle()
                                            .fill(Color.chillyBlack)
                                            .frame(width: 100, height: 100)
                                        Rectangle()
                                            .fill(Color.chillyBlack)
                                            .frame(width: 100, height: 100)
                                        Rectangle()
                                            .fill(Color.chillyBlack)
                                            .frame(width: 100, height: 100)
                                    }

                                case let .loaded(userAchievements):
                                    HStack {
                                        ForEach(userAchievements.filter { $0.category == "回数" } ) { achievement in
                                            if let url = achievement.image {
                                                LazyImage(url: url) { state in
                                                    if let image = state.image {
                                                        image
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: 96, height: 96)
                                                            .clipShape(Circle())
                                                            .overlay {
                                                                Circle()
                                                                    .stroke(Color.chillyBlack, style: StrokeStyle(lineWidth: 2))
                                                            }
                                                    } else if state.error != nil {
                                                        Circle()
                                                            .stroke(Color.chillyBlack, style: StrokeStyle(lineWidth: 2))
                                                            .fill(Color.chillyWhite)
                                                            .frame(width: 96, height: 96)
                                                    } else {
                                                        Circle()
                                                            .stroke(Color.chillyBlack, style: StrokeStyle(lineWidth: 2))
                                                            .fill(Color.chillyWhite)
                                                            .frame(width: 96, height: 96)
                                                    }
                                                }
                                            } else {
                                                Image.achievementDefault
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 96, height: 96)
                                                    .clipShape(Circle())
                                                    .overlay {
                                                        Circle()
                                                            .stroke(Color.chillyBlack, style: StrokeStyle(lineWidth: 2))
                                                    }
                                            }
                                        }
                                    }
                                    .padding(4)
                                }
                            }
                        }

                        VStack(alignment: .leading, spacing: 14) {
                            Text("連続")
                                .font(Font.customFont(.zenKakuGothicAntiqueMedium, size: 20))
                            ScrollView(.horizontal) {
                                switch self.viewStore.userAchievements {
                                case .initialized, .loading:
                                    HStack {
                                        Rectangle()
                                            .fill(Color.chillyBlack)
                                            .frame(width: 100, height: 100)
                                        Rectangle()
                                            .fill(Color.chillyBlack)
                                            .frame(width: 100, height: 100)
                                        Rectangle()
                                            .fill(Color.chillyBlack)
                                            .frame(width: 100, height: 100)
                                        Rectangle()
                                            .fill(Color.chillyBlack)
                                            .frame(width: 100, height: 100)
                                    }

                                case let .loaded(userAchievements):
                                    HStack {
                                        ForEach(userAchievements.filter { $0.category == "連続" } ) { achievement in
                                            if let url = achievement.image {
                                                LazyImage(url: url) { state in
                                                    if let image = state.image {
                                                        image
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: 96, height: 96)
                                                            .clipShape(Circle())
                                                            .overlay {
                                                                Circle()
                                                                    .stroke(Color.chillyBlack, style: StrokeStyle(lineWidth: 2))
                                                            }
                                                    } else if state.error != nil {
                                                        Circle()
                                                            .stroke(Color.chillyBlack, style: StrokeStyle(lineWidth: 2))
                                                            .fill(Color.chillyWhite)
                                                            .frame(width: 96, height: 96)
                                                    } else {
                                                        Circle()
                                                            .stroke(Color.chillyBlack, style: StrokeStyle(lineWidth: 2))
                                                            .fill(Color.chillyWhite)
                                                            .frame(width: 96, height: 96)
                                                    }
                                                }
                                            } else {
                                                Image.achievementDefault
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 96, height: 96)
                                                    .clipShape(Circle())
                                                    .overlay {
                                                        Circle()
                                                            .stroke(Color.chillyBlack, style: StrokeStyle(lineWidth: 2))
                                                    }
                                            }
                                        }
                                    }
                                    .padding(4)
                                }
                            }
                        }
                    }
                }
                .padding(.vertical, 8)
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
