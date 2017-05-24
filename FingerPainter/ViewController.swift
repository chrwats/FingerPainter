//
//  ViewController.swift
//  FingerPainter
//
//  Created by CHRISTOPHER WATSON on 05/24/17.
//  Copyright © 2017 CWatson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var start : CGPoint?
    
    @IBAction func clearImage(_ sender: UIBarButtonItem) {
         canvas.image = nil
    }
    @IBOutlet weak var canvas: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            start = touch.location(in: view)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let end = touch.location(in: canvas)
            if let start = self.start {
                drawFromPoint(start, toPoint: end)
            }
            self.start = end
        }
    }
    func drawFromPoint(_ start: CGPoint, toPoint end: CGPoint){
        // print coordinate with breakpoint here
        // set the context to that of an image
        UIGraphicsBeginImageContext(canvas.frame.size)
        let context = UIGraphicsGetCurrentContext()
        // draw the existing image onto the current context
        canvas.image?.draw(in: CGRect(x: 0, y: 0,
                                        width: canvas.frame.size.width,
                                        height: canvas.frame.size.height))
        // draw the new line segment
        context?.setLineWidth(5)
        context?.setStrokeColor(UIColor.magenta.cgColor)
        context?.beginPath()
        context?.move(to: CGPoint(x: start.x, y: start.y))
        context?.addLine(to: CGPoint(x: end.x, y: end.y))
        context?.strokePath()
        // obtain a UIImage object from the context
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        // Set the UIImageView's image to the new, generated image
        canvas.image = newImage
    }
}

