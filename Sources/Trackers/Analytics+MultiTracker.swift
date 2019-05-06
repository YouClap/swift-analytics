// Copied and modified from https://github.com/Mindera/Alicerce/blob/master/Sources/Analytics/Trackers/Analytics+MultiTracker.swift 🙏

public extension Analytics {
    final class MultiTracker: AnalyticsTracker {

        enum Error: Swift.Error {
            /// A tracker with the same id already registered.
            case duplicateTracker(AnalyticsTracker.ID)

            /// A tracker with the given id isn't registered.
            case inexistentTracker(AnalyticsTracker.ID)
        }

        /// The registered sub trackers (read only).
        public var trackers: [AnalyticsTracker] { return _trackers.value }

        /// The registered sub trackers.
        private let _trackers: Atomic<[AnalyticsTracker]>

        /// Creates an analytics multi tracker instance.
        public init() {
            self._trackers = Atomic<[AnalyticsTracker]>([])
        }

        // MARK: - Sub-Tracker Management

        /// Registers a sub tracker, and starts sending any new analytics events to it. This method is thread safe.
        ///
        /// - Parameter tracker: The analytics tracker to register.
        /// - Throws: An `Analytics.MultiTrackerError.duplicateTracker` error if a tracker with the same `id` is
        /// already registered.
        public func register(_ tracker: AnalyticsTracker) throws {
            precondition(tracker.identifier != identifier, "🙅‍♂️ Can't register a tracker with the same `id` as `self`!")

            try _trackers.modify {
                guard $0.contains(where: { $0.identifier == tracker.identifier }) == false else {
                    throw Error.duplicateTracker(tracker.identifier)
                }
                $0.append(tracker)
            }
        }

        /// Unregisters a sub tracker, preventing any new analytics events from being sent to it. This method is thread
        /// safe.
        ///
        /// - Parameter tracker: The analytics tracker to unregister.
        /// - Throws: An `Analytics.MultiTrackerError.inexistentTracker` error if a tracker with the same `id` isn't
        /// registered.
        public func unregister(_ tracker: AnalyticsTracker) throws {
            try _trackers.modify {
                guard $0.contains(where: { $0.identifier == tracker.identifier }) else {
                    throw Error.inexistentTracker(tracker.identifier)
                }
                $0 = $0.filter { $0.identifier != tracker.identifier }
            }
        }

        // MARK: - Tracking

        /// Tracks an analytics event, by propagating it to all the registered sub trackers.
        ///
        /// - Parameter event: The event to track.
        public func track<State, Action, ParameterKey>(_ event: Analytics.Event<State, Action, ParameterKey>)
        where ParameterKey: AnalyticsParameterKey {
            let currentTrackers = trackers

            guard currentTrackers.isEmpty == false else { return }

            currentTrackers.forEach { $0.track(event) }
        }
    }
}

