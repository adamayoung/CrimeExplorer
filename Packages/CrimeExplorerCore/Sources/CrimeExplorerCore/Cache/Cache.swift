import Foundation

final class Cache<Key: CustomStringConvertible, Value: Any> {

    private var cache = NSCache<NSString, ValueBox<Value>>()

    init() { }

    subscript(key: Key) -> Value? {
        get {
            let key = key.description as NSString
            return cache.object(forKey: key)?.value
        }

        set {
            let key = key.description as NSString
            if let newValue = newValue {
                cache.setObject(ValueBox(newValue), forKey: key)
            } else {
                cache.removeObject(forKey: key)
            }
        }
    }

}

private class ValueBox<Value: Any> {

    let value: Value

    init(_ value: Value) {
        self.value = value
    }

}
