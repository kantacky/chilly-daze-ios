import ComposableArchitecture

@Reducer
public struct RecordReducer {
    // MARK: - State
    public struct State: Equatable {
        public init() {}
    }

    // MARK: - Action
    public enum Action {
        case onAppear
        case onRefresh
    }

    // MARK: - Dependencies

    public init() {}

    // MARK: - Reducer
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .send(.onRefresh)

            case .onRefresh:
                return .none
            }
        }
    }
}
