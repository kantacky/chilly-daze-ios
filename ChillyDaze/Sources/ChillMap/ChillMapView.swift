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
        self.store = store
        self._viewStore = .init(
            wrappedValue: ViewStore(store, observe: { $0 })
        )
    }

    public var body: some View {
        Group {
            switch self.viewStore.scene {
            case .ready, .inSession(_), .ending(_):
                ZStack {
                    Map(position: self.viewStore.$mapCameraPosition) {
                        UserAnnotation()
                            .tint(Color.chillyBlue)

                        switch self.viewStore.chills {
                        case let .loaded(chills):
                            ForEach(chills) { chill in
                                MapPolyline(coordinates: chill.traces.sorted(by: { $0.timestamp < $1.timestamp }).map {
                                    $0.coordinate
                                })
                                .stroke(
                                    Color.chillyBlue2,
                                    style: .init(
                                        lineWidth: 58,
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
                                    lineWidth: 58,
                                    lineCap: .round,
                                    lineJoin: .round
                                )
                            )

                        default:
                            EmptyMapContent()
                        }
                    }

                    VStack {
                        Spacer()

                        switch self.viewStore.scene {
                        case .ready:
                            ChillyButton(
                                labelText: "Start",
                                labelImage: "play.fill"
                            ) {
                                self.viewStore.send(.onStartButtonTapped)
                            }

                        case .inSession(_), .ending(_):
                            HStack(spacing: 16.5) {
                                ChillyButton(
                                    labelText: "Stop",
                                    labelImage: "stop.fill",
                                    foregroundColor: .chillyWhite,
                                    backgroundColor: .chillyBlack
                                ) {
                                    self.viewStore.send(.onStopButtonTapped)
                                }

                                ChillyButton(
                                    labelImage: "camera.fill"
                                ) {
                                    self.viewStore.send(.onCameraButtonTapped)
                                }
                            }

                        default:
                            EmptyView()
                        }

                        Spacer()
                            .frame(height: 41)
                    }

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

                    default:
                        EmptyView()
                    }
                }
                .onAppear {
                    self.viewStore.send(.onAppear)
                }

            case let .welcomeBack(chill):
                WelcomeBackView(chill: chill) {

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
