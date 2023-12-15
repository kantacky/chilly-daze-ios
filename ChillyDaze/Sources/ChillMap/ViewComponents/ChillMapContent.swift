import ComposableArchitecture
import MapKit
import Resources
import SwiftUI

struct ChillMapContent: View {
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
        Group {
        }
    }
}

#Preview {
    ChillMapContent(store: Store(
        initialState: ChillMapView.Reducer.State(),
        reducer: { ChillMapView.Reducer() }
    ))
}
