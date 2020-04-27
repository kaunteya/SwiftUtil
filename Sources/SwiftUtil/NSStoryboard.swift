import Cocoa

public extension NSStoryboard {
    static var main: NSStoryboard {
        return NSStoryboard(name: "Main", bundle: nil)
    }

    func viewController<T>(_ id: String) -> T where T: NSViewController {
        return instantiateController(withIdentifier: id) as! T
    }

    func windowController<T>(_ id: String) -> T where T: NSWindowController {
        return instantiateController(withIdentifier: id) as! T
    }
}
