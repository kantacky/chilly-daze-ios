import ComposableArchitecture
import Models
import Resources
import SwiftUI

@Reducer
public struct CameraReducer {
    // MARK: - State
    public struct State: Equatable {
        let camera: Camera = .init()
        var previewImage: UIImage
        var shotImage: UIImage?

        public init() {
            self.previewImage = UIImage.appIcon
        }
    }

    // MARK: - Action
    public enum Action {
        case onAppear
        case refreshPreview(UIImage)
        case onXButtonTapped
        case onShutterButtonTapped
        case onRecordButtonTapped(UIImage)
    }

    // MARK: - Dependencies

    public init() {}

    public enum CancelID {
        case cameraPreviewImageStreamSubscription
    }

    // MARK: - Reducer
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .run { [camera = state.camera] send in
                    await camera.start()

                    let imageStream = camera.previewStream
                        .map { $0 }


                    for await image in imageStream {
                        Task { @MainActor in
                            send(.refreshPreview(UIImage(ciImage: image)))
                        }
                    }
                }
                .cancellable(id: CancelID.cameraPreviewImageStreamSubscription)

            case let .refreshPreview(image):
                let size = image.size.width > image.size.height ? image.size.height : image.size.width
                let x = image.size.width > image.size.height ? (image.size.width - size) / 2 : 0
                let y = image.size.width < image.size.height ? (image.size.height - size) / 2 : 0

                if let image = image.cropped(to: .init(x: x, y: y, width: size, height: size)) {
                    state.previewImage = image
                }
                return .none

            case .onXButtonTapped:
                Task.cancel(id: CancelID.cameraPreviewImageStreamSubscription)
                return .run { [camera = state.camera] _ in
                    camera.stop()
                }

            case .onShutterButtonTapped:
                let image = state.previewImage
                let size = image.size.width > image.size.height ? image.size.height : image.size.width
                let x = image.size.width > image.size.height ? (image.size.width - size) / 2 : 0
                let y = image.size.width < image.size.height ? (image.size.height - size) / 2 : 0

                state.shotImage = image.cropped(to: .init(x: x, y: y, width: size, height: size))
                state.shotImage = state.previewImage
                return .none

            case .onRecordButtonTapped(_):
                Task.cancel(id: CancelID.cameraPreviewImageStreamSubscription)
                return .run { [camera = state.camera] _ in
                    camera.stop()
                }
            }
        }
    }
}
