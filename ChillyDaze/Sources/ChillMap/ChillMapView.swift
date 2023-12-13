import ComposableArchitecture
import MapKit
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

                
            }

            VStack {
                Spacer()

                if let _ = self.viewStore.chill {
                    HStack(spacing: 16.5) {
                        ChillyButton(buttonCategory: .stop) {
                            self.viewStore.send(.onStopButtonTapped)
                        }

                        ChillyButton(buttonCategory: .camera) {
                            self.viewStore.send(.onCameraButtonTapped)
                        }
                    }
                } else {
                    ChillyButton(buttonCategory: .start) {
                        self.viewStore.send(.onStartButtonTapped)
                    }
                }

                Spacer()
                    .frame(height: 41)
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
