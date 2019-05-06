
public enum Analytics {
    public typealias Parameters<Key: AnalyticsParameterKey> = [Key : Any]

    public enum Event<State, Action, Key: AnalyticsParameterKey> {
        case state(State, Parameters<Key>?)
        case action(Action, Parameters<Key>?)
    }
}

