import ComposableArchitecture
import MapKit
import Models
import Resources
import SwiftUI

public struct ChillMapView: View {
    public typealias Reducer = ChillMapReducer
    private let store: StoreOf<Reducer>
    @StateObject private var viewStore: ViewStoreOf<Reducer>

    public init(store: StoreOf<Reducer>) {
        Font.registerCustomFonts()
        self.store = store
        self._viewStore = .init(
            wrappedValue: ViewStore(store, observe: { $0 })
        )
    }

    public var body: some View {
        Group {
            switch self.viewStore.scene {
            case .ready, .inSession(_), .ending(_), .newAchievement(_):
                ZStack {
                    Map(position: self.viewStore.$mapCameraPosition) {
                        UserAnnotation()

                        switch self.viewStore.chills {
                        case let .loaded(chills):
                            ForEach(chills) { chill in
                                MapPolyline(coordinates: chill.traces.sorted(by: { $0.timestamp < $1.timestamp }).map {
                                    $0.coordinate
                                })
                                .stroke(
                                    Color.chillyBlue2,
                                    style: .init(
                                        lineWidth: 32,
                                        lineCap: .round,
                                        lineJoin: .round
                                    )
                                )
                            }

                        default:
                            EmptyMapContent()
                        }

                        switch self.viewStore.scene {
                        case let .inSession(chill), let .ending(chill):
                            MapPolyline(coordinates: chill.traces.sorted(by: { $0.timestamp < $1.timestamp }).map {
                                $0.coordinate
                            })
                            .stroke(
                                Color.chillyBlue3,
                                style: .init(
                                    lineWidth: 32,
                                    lineCap: .round,
                                    lineJoin: .round
                                )
                            )

                        default:
                            EmptyMapContent()
                        }
                    }

                    ChillMapButtons(store: self.store)

                    switch self.viewStore.scene {
                    case .ending(_):
                        ChillyAlert(
                            message: "アクティビティを終了しますか？",
                            cancelAction: {
                                self.viewStore.send(.onEndChillAlertCancelButtonTapped)
                            },
                            primaryAction: {
                                self.viewStore.send(.onEndChillAlertStopButtonTapped)
                            },
                            primaryLabel: "終了"
                        )

                    case let .newAchievement(achievements):
                        NewAchievementDialog(achievement: achievements[0]) {
                            self.viewStore.send(.onNewAchievementOkButtonTapped(achievements))
                        }

                    default:
                        EmptyView()
                    }
                }
                .onAppear {
                    self.viewStore.send(.onAppear)
                }

            case let .welcomeBack(chill):
                WelcomeBackView(chill: chill) { shot in
                    self.viewStore.send(.onWelcomeBackOkButtonTapped(shot))
                }
            }
        }
        .alert(store: self.store.scope(state: \.$alert, action: Reducer.Action.alert))
    }
}

#Preview {
    ChillMapView(store: Store(
        initialState: ChillMapView.Reducer.State(),
        reducer: { ChillMapView.Reducer() }
    ))
}
