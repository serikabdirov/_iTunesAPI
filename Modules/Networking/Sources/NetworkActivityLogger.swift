import Alamofire
import Foundation

public actor NetworkActivityLogger {
    public enum Level {
        /// Logs HTTP method, URL, header fields, & request body for requests, and status code, URL, header fields,
        /// response string, & elapsed time for responses.
        case debug
        /// Logs HTTP method & URL for requests, and status code, URL, & elapsed time for responses.
        case info
        /// Logs HTTP method & URL for requests, and status code, URL, & elapsed time for responses, but only
        /// for failed requests.
        case warn
    }

    /// Current log level
    public var level: Level

    public init(level: Level) {
        self.level = level
    }

    private func logStart(_ request: Request) {
        guard let dataRequest = request as? DataRequest,
              let task = dataRequest.task,
              let request = task.originalRequest,
              let httpMethod = request.httpMethod,
              let requestURL = request.url
        else {
            return
        }

        switch level {
        case .debug:
            logDivider()
            print("\(httpMethod) '\(requestURL.absoluteString)':")
            print(dataRequest.cURLDescription())
        case .info:
            logDivider()
            print("\(httpMethod) '\(requestURL.absoluteString)'")
        default:
            break
        }
    }

    private func logFinish(_ request: Request) {
        guard let dataRequest = request as? DataRequest,
              let task = dataRequest.task,
              let metrics = dataRequest.metrics,
              let request = task.originalRequest,
              let httpMethod = request.httpMethod,
              let requestURL = request.url
        else {
            return
        }

        let elapsedTime = metrics.taskInterval.duration

        if let error = task.error {
            print("[Error] \(httpMethod) '\(requestURL.absoluteString)' [\(String(format: "%.04f", elapsedTime)) s]:")
            print(error)
        } else {
            guard let response = task.response as? HTTPURLResponse else {
                return
            }
            switch level {
            case .debug:
                logDivider()
                let elapsedTimeString = String(format: "%.04f", elapsedTime)
                print("\(String(response.statusCode)) '\(requestURL.absoluteString)' [\(elapsedTimeString) s]:")
                logHeaders(headers: response.allHeaderFields)
                guard let data = dataRequest.data else { break }
                print("Body:")
                do {
                    let jsonObject = try JSONSerialization.jsonObject(
                        with: data,
                        options: .mutableContainers
                    )
                    let prettyData = try JSONSerialization.data(
                        withJSONObject: jsonObject,
                        options: .prettyPrinted
                    )
                    if let prettyString = String(data: prettyData, encoding: .utf8) {
                        print(prettyString)
                    }
                } catch {
                    if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                        print(string)
                    }
                }
            case .info:
                logDivider()
                let elapsedTimeString = String(format: "%.04f", elapsedTime)
                print("\(String(response.statusCode)) '\(requestURL.absoluteString)' [\(elapsedTimeString) s]")
            case .warn:
                break
            }
        }
    }

    private func logDivider() {
        print("---------------------")
    }

    private func logHeaders(headers: [AnyHashable: Any]) {
        print("Headers: [")
        for (key, value) in headers {
            print("  \(key): \(value)")
        }
        print("]")
    }
}

extension NetworkActivityLogger: EventMonitor {
    public nonisolated func request(_ request: Request, didCreateTask task: URLSessionTask) {
        Task(priority: .background) { await logStart(request) }
    }

    public nonisolated func requestDidFinish(_ request: Request) {
        Task(priority: .background) { await logFinish(request) }
    }
}
