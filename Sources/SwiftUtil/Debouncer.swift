import Foundation

public class Debouncer {
    public typealias Handler = () -> Void

    private let timeInterval: TimeInterval
    var handler: Handler?

    public init(timeInterval: TimeInterval, handler: Handler? = nil) {
        self.timeInterval = timeInterval
        self.handler = handler
    }

    private var timer: Timer?

    public func renewInterval() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { [weak self] _ in
            self?.handler?()
        }
    }
}
