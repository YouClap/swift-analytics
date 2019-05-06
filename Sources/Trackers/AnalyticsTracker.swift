// Copied and modified from https://github.com/Mindera/Alicerce/blob/master/Sources/Analytics/Trackers/AnalyticsTracker.swift 🙏

public protocol AnalyticsTracker: AnyObject {
    /// A type that represents all the possible types that the tracker's `Event.state` event can have.
    associatedtype State

    /// A type that represents all the possible types that the tracker's `Event.action` event can have.
    associatedtype Action

    /// A type that represents all the possible parameter keys that a tracker's `Event` parameter dictionary can have.
    associatedtype ParameterKey: AnalyticsParameterKey

    /// An analytics event.
    typealias Event = Analytics.Event<State, Action, ParameterKey>

    /// A type representing a tracker's identifier.
    typealias ID = String

    /// The identifier of the tracker. The default is the tracker's type name.
    var identifier: ID { get }

    /// Tracks an analytics event.
    ///
    /// - Parameter event: The event to track.
    func track(_ event: Event)
}

extension AnalyticsTracker {
    public var identifier: ID { return "\(type(of: self))" }
}
