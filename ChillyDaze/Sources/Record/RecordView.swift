import ComposableArchitecture
import SwiftUI

public struct RecordView: View {
    public typealias Reducer = RecordReducer
    private let store: StoreOf<Reducer>
    @StateObject private var viewStore: ViewStoreOf<Reducer>

    public init(store: StoreOf<Reducer>) {
        self.store = store
        self._viewStore = .init(wrappedValue: ViewStore(store, observe: { $0 }))
    }

    public var body: some View {
        Text("Record")
    }
}

#Preview {
    RecordView(store: Store(
        initialState: RecordView.Reducer.State(),
        reducer: { RecordView.Reducer() }
    ))
}
