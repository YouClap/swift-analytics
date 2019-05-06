// Copied and modified from https://github.com/Mindera/Alicerce/blob/master/Sources/Analytics/Trackers/AnalyticsTracker.swift 🙏

public protocol AnalyticsTracker: AnyObject {
    /// A type representing a tracker's identifier.
    typealias ID = String

    /// The identifier of the tracker. The default is the tracker's type name.
    var identifier: ID { get }

    /// Tracks an analytics event.
    ///
    /// - Parameter event: The event to track.
    func track<State, Action, ParameterKey>(_ event: Analytics.Event<State, Action, ParameterKey>)
    where ParameterKey: AnalyticsParameterKey
}

extension AnalyticsTracker {
    public var identifier: ID { return "\(type(of: self))" }
}
