@_exported import Alamofire
@_exported import Foundation

/// Default ApiClient realisation
/// Creates and manages Alamofire's `Session` to perform requests
public class ApiClient {
    private let session: Session

    /// Init
    /// - Parameters:
    ///   - configuration: `URLSessionConfiguration` used to configure session
    ///   - interceptor: `RequestInterceptor` to be used for all `Request`s created by this instance
    ///   - eventMonitors: Additional `EventMonitor`s used by the instance
    public init(
        configuration: URLSessionConfiguration = .af.default,
        interceptor: RequestInterceptor? = nil,
        eventMonitors: [EventMonitor] = []
    ) {
        self.session = Session(configuration: configuration, interceptor: interceptor, eventMonitors: eventMonitors)
    }

    /// Creates and performs plain `DataRequest`
    /// - Parameter target: `TargetType` value to be used to create the `URLRequest`
    /// - Parameter interceptor: RequestInterceptor` value to be used by the returned `DataRequest`. `nil` by default.
    /// - Returns: `DataResponse` produced by the `DataRequest`
    public func load(
        _ target: TargetType,
        interceptor: RequestInterceptor? = nil
    ) async -> DataResponse<Data, AFError> {
        await session.request(target, interceptor: interceptor)
            .serializingData(automaticallyCancelling: true)
            .response
    }

    /// Creates and performs plain `DataRequest`
    /// - Parameter target: `TargetType` value to be used to create the `URLRequest`
    /// - Parameter interceptor: RequestInterceptor` value to be used by the returned `DataRequest`. `nil` by default.
    /// - Parameter responseSerializer: `ResponseSerializer` responsible for serializing the request,
    /// response, and data.
    /// - Returns: `DataResponse` produced by the `DataRequest`
    public func load<S: ResponseSerializer>(
        _ target: TargetType,
        interceptor: RequestInterceptor? = nil,
        responseSerializer: S
    ) async -> DataResponse<S.SerializedObject, AFError> {
        await session.request(target, interceptor: interceptor)
            .serializingResponse(using: responseSerializer, automaticallyCancelling: true)
            .response
    }

    /// Creates and performs `UploadRequest` for the given `Data`
    /// - Parameters:
    ///   - data: The `Data` to upload
    ///   - target: `TargetType` value to be used to create the `URLRequest`
    /// - Returns: `DataResponse` produced by the `UploadRequest`
    public func upload(
        data: Data,
        with target: TargetType
    ) async -> DataResponse<Data, AFError> {
        await session.upload(data, with: target)
            .serializingData(automaticallyCancelling: true)
            .response
    }

    /// Creates and performs `UploadRequest` for the given `Data`
    /// - Parameters:
    ///   - data: The `Data` to upload.
    ///   - target: `TargetType` value to be used to create the `URLRequest`
    ///   - uploadProgress: The closure to be executed periodically as data is sent to the server
    /// - Returns: `DataResponse` produced by the `UploadRequest`
    public func upload(
        data: Data,
        with target: TargetType,
        uploadProgress: @escaping Request.ProgressHandler
    ) async -> DataResponse<Data, AFError> {
        await session.upload(data, with: target)
            .uploadProgress(closure: uploadProgress)
            .serializingData(automaticallyCancelling: true)
            .response
    }

    /// Creates and performs `UploadRequest` for the file at the given file `URL`
    /// - Parameters:
    ///   - fileURL: The `URL` of the file to upload
    ///   - target: `TargetType` value to be used to create the `URLRequest`
    /// - Returns: `DataResponse` produced by the `UploadRequest`
    public func upload(
        fileURL: URL,
        with target: TargetType
    ) async -> DataResponse<Data, AFError> {
        await session.upload(fileURL, with: target)
            .serializingData(automaticallyCancelling: true)
            .response
    }

    /// Creates and performs `UploadRequest` for the file at the given file `URL`
    /// - Parameters:
    ///   - fileURL: The `URL` of the file to upload
    ///   - target: `TargetType` value to be used to create the `URLRequest`
    ///   - uploadProgress: The closure to be executed periodically as data is sent to the server
    /// - Returns: `DataResponse` produced by the `UploadRequest`
    public func upload(
        fileURL: URL,
        with target: TargetType,
        uploadProgress: @escaping Request.ProgressHandler
    ) async -> DataResponse<Data, AFError> {
        await session.upload(fileURL, with: target)
            .uploadProgress(closure: uploadProgress)
            .serializingData(automaticallyCancelling: true)
            .response
    }

    /// Creates and performs `UploadRequest` for the prebuilt `MultipartFormData`
    /// - Parameters:
    ///   - multipartFormData: `MultipartFormData` instance to upload
    ///   - target: `TargetType` value to be used to create the `URLRequest`
    /// - Returns: `DataResponse` produced by the `UploadRequest`
    public func upload(
        multipartFormData: MultipartFormData,
        with target: TargetType
    ) async -> DataResponse<Data, AFError> {
        await session.upload(multipartFormData: multipartFormData, with: target)
            .serializingData(automaticallyCancelling: true)
            .response
    }

    /// Creates and performs `UploadRequest` for the prebuilt `MultipartFormData`
    /// - Parameters:
    ///   - multipartFormData: `MultipartFormData` instance to upload
    ///   - target: `TargetType` value to be used to create the `URLRequest`
    ///   - uploadProgress: The closure to be executed periodically as data is sent to the server
    /// - Returns: `DataResponse` produced by the `UploadRequest`
    public func upload(
        multipartFormData: MultipartFormData,
        with target: TargetType,
        uploadProgress: @escaping Request.ProgressHandler
    ) async -> DataResponse<Data, AFError> {
        await session.upload(multipartFormData: multipartFormData, with: target)
            .uploadProgress(closure: uploadProgress)
            .serializingData(automaticallyCancelling: true)
            .response
    }

    /// Creates and performs `DownloadRequest`
    /// - Parameter target: `TargetType` value to be used to create the `URLRequest`
    /// - Returns: `DownloadResponse` produced by the `DownloadRequest`
    public func download(_ target: TargetType) async -> DownloadResponse<Data, AFError> {
        await session.download(target)
            .serializingData(automaticallyCancelling: true)
            .response
    }

    /// Creates and performs `DownloadRequest`
    /// - Parameter target: `TargetType` value to be used to create the `URLRequest`
    /// - Parameter downloadProgress: The closure to be executed periodically as data is read from the server
    /// - Returns: `DownloadResponse` produced by the `DownloadRequest`
    public func download(
        _ target: TargetType,
        downloadProgress: @escaping Request.ProgressHandler
    ) async -> DownloadResponse<Data, AFError> {
        await session.download(target)
            .downloadProgress(closure: downloadProgress)
            .serializingData(automaticallyCancelling: true)
            .response
    }

    /// Creates and performs `DownloadRequest`to load data to a `Destination`
    /// - Parameter target: `TargetType` value to be used to create the `URLRequest`
    /// - Parameter to: `DownloadRequest.Destination` closure used to determine how and where the downloaded file
    ///                  should be moved.
    /// - Returns: `DownloadResponse` produced by the `DownloadRequest`
    public func download(
        _ target: TargetType,
        to destination: DownloadRequest.Destination? = nil
    ) async -> DownloadResponse<URL, AFError> {
        await session.download(target, to: destination)
            .serializingDownloadedFileURL(automaticallyCancelling: true)
            .response
    }

    /// Creates and performs `DownloadRequest`to load data to a `Destination`
    /// - Parameter target: `TargetType` value to be used to create the `URLRequest`
    /// - Parameter to: `DownloadRequest.Destination` closure used to determine how and where the downloaded file
    ///                  should be moved.
    /// - Parameter downloadProgress: The closure to be executed periodically as data is read from the server
    /// - Returns: `DownloadResponse` produced by the `DownloadRequest`
    public func download(
        _ target: TargetType,
        to destination: DownloadRequest.Destination? = nil,
        downloadProgress: @escaping Request.ProgressHandler
    ) async -> DownloadResponse<URL, AFError> {
        await session.download(target, to: destination)
            .downloadProgress(closure: downloadProgress)
            .serializingDownloadedFileURL(automaticallyCancelling: true)
            .response
    }
}
