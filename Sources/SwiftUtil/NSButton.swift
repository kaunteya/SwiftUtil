import Cocoa

public extension NSButton {

    func title(_ a: String) -> Self {
        title = a; return self
    }

    func alternateTitle(_ a: String) -> Self {
        alternateTitle = a; return self
    }

    func sound(_ a: NSSound?) -> Self {
        sound = a; return self
    }

    func bezelStyle(_ a: NSButton.BezelStyle) -> Self {
        bezelStyle = a; return self
    }

    func bordered(_ a: Bool) -> Self {
        isBordered = a; return self
    }

    func transparent(_ a: Bool) -> Self {
        isTransparent = a; return self
    }

    /* A Boolean value that determines whether the button displays its border only when the pointer is over it. */
    func showsBorderOnlyWhileMouseInside() -> Self {
        showsBorderOnlyWhileMouseInside = true; return self
    }

    func image(_ a: NSImage) -> Self {
        image = a; return self
    }

    func alternateImage(_ aa: NSImage) -> Self {
        alternateImage = aa; return self
    }

    func imagePosition(_ a: NSControl.ImagePosition) -> Self {
        imagePosition = a; return self
    }


    func imageScaling(_ a: NSImageScaling) -> Self {
        imageScaling = a; return self
    }

    func state(_ a: NSControl.StateValue) -> Self {
        state = a; return self
    }
}
