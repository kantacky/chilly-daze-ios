import ComposableArchitecture
import Resources
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
        ScrollView {
            VStack {
                HStack(spacing: 24) {
                    Rectangle()
                        .fill(Color.gray)
                        .frame(
                            width: (UIScreen.main.bounds.width - 72) / 2,
                            height: (UIScreen.main.bounds.width - 72) / 2
                        )

                    Rectangle()
                        .fill(Color.gray)
                        .frame(
                            width: (UIScreen.main.bounds.width - 72) / 2,
                            height: (UIScreen.main.bounds.width - 72) / 2
                        )
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.chillyWhite)
    }
}

#Preview {
    RecordView(store: Store(
        initialState: RecordView.Reducer.State(),
        reducer: { RecordView.Reducer() }
    ))
}
