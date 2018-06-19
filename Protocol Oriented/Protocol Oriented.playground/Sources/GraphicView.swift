import UIKit
import PlaygroundSupport

let drawingArea = CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0)

/// `CoreGraphicsDiagramView` is a `UIView` that draws itself by calling a
/// user-supplied function to generate paths in a `CGContext`, then strokes
/// the context's current path, creating lines in a pleasing shade of blue.
class DrawingView : UIView {
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        context.saveGState()
        
        draw(context)
        
        let lightBlue = UIColor(red:0.222, green: 0.999, blue: 0.976, alpha:1.0)
        context.setStrokeColor(lightBlue.cgColor)
        context.setLineWidth(3)
        context.strokePath()
        
        context.restoreGState()
    }
    
    var draw: (CGContext)->() = { _ in () }
}

/// Shows a `UIView` in the current playground that draws itself by invoking
/// `draw` on a `CGContext`, then stroking the context's current path in a
/// pleasing light blue.
public func showCoreGraphicsDiagram(_ title: String, draw: @escaping (CGContext)->()) {
    let diagramView = DrawingView(frame: drawingArea)
    diagramView.draw = draw
    diagramView.setNeedsDisplay()
    PlaygroundPage.current.liveView = diagramView
}




