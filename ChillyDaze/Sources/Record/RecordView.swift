import ComposableArchitecture
import Resources
import SwiftUI

public struct RecordView: View {
    public typealias Reducer = RecordReducer
    private let store: StoreOf<Reducer>
    @StateObject private var viewStore: ViewStoreOf<Reducer>

    public init(store: StoreOf<Reducer>) {
        Font.registerCustomFonts()
        self.store = store
        self._viewStore = .init(wrappedValue: ViewStore(store, observe: { $0 }))
    }

    public var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 10) {
                VStack(spacing: 10) {
                    ZStack {
                        Image.Banner.frequence
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width - 48)

                        HStack(alignment: .bottom, spacing: 0) {
                            Spacer()
                                .frame(width: 96)

                            Text("5")
                                .font(.customFont(.inikaRegular, size: 102))

                            VStack(spacing: 0) {
                                Text("/7")
                                    .font(.customFont(.inikaRegular, size: 30))

                                Spacer()
                                    .frame(height: 12)
                            }
                        }
                        .padding(.top, -20)
                    }
                    .tint(Color.chillyBlack)

                    ZStack {
                        Image.Banner.area
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width - 48)

                        HStack(alignment: .bottom, spacing: 0) {
                            Spacer()
                                .frame(width: 96)

                            Text("100")
                                .font(.customFont(.inikaRegular, size: 60))

                            VStack(spacing: 0) {
                                Text("%")
                                    .font(.customFont(.inikaRegular, size: 30))

                                Spacer()
                                    .frame(height: 8)
                            }
                        }
                    }
                    .tint(Color.chillyBlack)
                }

                VStack(spacing: 10) {
                    HStack(spacing: 10) {
                        Image.appIcon
                            .resizable()
                            .scaledToFit()
                            .frame(width: (UIScreen.main.bounds.width - 48 - 10) / 2)
                            .border(Color.chillyBlack, width: 2)

                        Image.appIcon
                            .resizable()
                            .scaledToFit()
                            .frame(width: (UIScreen.main.bounds.width - 48 - 10) / 2)
                            .border(Color.chillyBlack, width: 2)
                    }

                    HStack(spacing: 10) {
                        Image.appIcon
                            .resizable()
                            .scaledToFit()
                            .frame(width: (UIScreen.main.bounds.width - 48 - 10) / 2)
                            .border(Color.chillyBlack, width: 2)

                        Image.appIcon
                            .resizable()
                            .scaledToFit()
                            .frame(width: (UIScreen.main.bounds.width - 48 - 10) / 2)
                            .border(Color.chillyBlack, width: 2)
                    }


                    HStack(spacing: 10) {
                        Image.appIcon
                            .resizable()
                            .scaledToFit()
                            .frame(width: (UIScreen.main.bounds.width - 48 - 10) / 2)
                            .border(Color.chillyBlack, width: 2)

                        Image.appIcon
                            .resizable()
                            .scaledToFit()
                            .frame(width: (UIScreen.main.bounds.width - 48 - 10) / 2)
                            .border(Color.chillyBlack, width: 2)
                    }
                }
            }
        }
        .refreshable {
            self.viewStore.send(.onRefresh)
        }
        .padding(.top, 24)
        .padding(.horizontal, 24)
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
