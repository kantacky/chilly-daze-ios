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

                if let chill = self.viewStore.chill {
                    MapPolyline(coordinates: chill.traces.sorted(by: { $0.timestamp < $1.timestamp }).map {
                        $0.coordinate
                    })
                    .stroke(
                        Color.chillyBlue3,
                        style: .init(
                            lineWidth: 58,
                            lineCap: .round,
                            lineJoin: .miter
                        )
                    )
                }
            }

            VStack {
                Spacer()

                if let _ = self.viewStore.chill {
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
                } else {
                    ChillyButton(
                        labelText: "Start",
                        labelImage: "play.fill"
                    ) {
                        self.viewStore.send(.onStartButtonTapped)
                    }
                }

                Spacer()
                    .frame(height: 41)
            }

            if self.viewStore.endChillAlertIsShowing {
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
            }
        }
        .onAppear {
            self.viewStore.send(.onAppear)
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
