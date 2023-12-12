import ComposableArchitecture
import MapKit
import SwiftUI

public struct ChillMapView: View {
    public typealias Reducer = ChillMapReducer
    private let store: StoreOf<Reducer>
    @StateObject private var viewStore: ViewStoreOf<Reducer>

    public init(store: StoreOf<Reducer>) {
        self.store = store
        self._viewStore = .init(wrappedValue: ViewStore(store, observe: { $0 }))
    }

    public var body: some View {
        Map()
    }
}

#Preview {
    ChillMapView(store: Store(
        initialState: ChillMapView.Reducer.State(),
        reducer: { ChillMapView.Reducer() }
    ))
}
