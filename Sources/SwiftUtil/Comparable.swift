public extension Comparable {

    /// Return clamped value to min/max values.
    ///
    /// - Parameter range: Condition which receiver should be in between.
    /// - Returns: Processed value.
    func clamped(to range: ClosedRange<Self>) -> Self {
        max(range.lowerBound, min(self, range.upperBound))
    }
}
