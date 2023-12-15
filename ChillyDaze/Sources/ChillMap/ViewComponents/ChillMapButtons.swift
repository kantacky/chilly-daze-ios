import ComposableArchitecture
import SwiftUI

struct ChillMapButtons: View {
    typealias Reducer = ChillMapReducer
    private let store: StoreOf<Reducer>
    @StateObject private var viewStore: ViewStoreOf<Reducer>

    init(store: StoreOf<Reducer>) {
        self.store = store
        self._viewStore = .init(
            wrappedValue: ViewStore(store, observe: { $0 })
        )
    }

    var body: some View {
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
    }
}

#Preview {
    ChillMapButtons(store: Store(
        initialState: ChillMapView.Reducer.State(),
        reducer: { ChillMapView.Reducer() }
    ))
}
