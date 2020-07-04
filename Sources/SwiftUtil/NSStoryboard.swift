import Cocoa

public extension NSStoryboard {
    static var main: NSStoryboard {
        NSStoryboard(name: "Main", bundle: nil)
    }

    func viewController<T>(_ id: String) -> T where T: NSViewController {
        instantiateController(withIdentifier: id) as! T
    }

    func windowController<T>(_ id: String) -> T where T: NSWindowController {
        instantiateController(withIdentifier: id) as! T
    }
}
