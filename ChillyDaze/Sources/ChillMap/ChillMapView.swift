import ComposableArchitecture
import MapKit
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
                    .tint(Color(.chillyBlue))
            }

            VStack {
                Spacer()

                if let _ = self.viewStore.chill {
                    HStack(spacing: 16.5) {
                        ChillyButton(buttonCategory: .stop) {
                            print("Stop")
                        }

                        ChillyButton(buttonCategory: .camera) {
                            print("Camera")
                        }
                    }
                } else {
                    ChillyButton(buttonCategory: .start) {
                        print("Start")
                    }
                }

                Spacer()
                    .frame(height: 41)
            }
        }
        .onAppear {
            self.viewStore.send(.onAppear)
        }
    }
}

#Preview {
    ChillMapView(store: Store(
        initialState: ChillMapView.Reducer.State(),
        reducer: { ChillMapView.Reducer() }
    ))
}
