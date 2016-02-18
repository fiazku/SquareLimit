//
//  ViewController.swift
//  SquareLimit
//
//  Created by Fiaz Sami on 2/17/16.
//  Copyright © 2016 mobilemakers. All rights reserved.
//

import UIKit

typealias CopyFunc = (UIView, CGFloat) -> UIView

func copyRight(square: UIView, scale: CGFloat) -> UIView {
    let frame = CGRect(
        x: square.frame.origin.x + square.frame.width,
        y: square.frame.origin.y,
        width: square.frame.width * scale,
        height: square.frame.height)

    return UIView(frame: frame)
}

func copyBelow(square: UIView, scale: CGFloat) -> UIView {
    let frame = CGRect(
        x: square.frame.origin.x,
        y: square.frame.origin.y + square.frame.height,
        width: square.frame.width,
        height: square.frame.height * scale)

    return UIView(frame: frame)
}

func copyLeft(square: UIView, scale: CGFloat) -> UIView {
    let frame = CGRect(x: square.frame.origin.x - square.frame.width * scale, y: square.frame.origin.y, width: square.frame.width * scale, height: square.frame.height)

    return UIView(frame: frame)
}

func copyAbove(square: UIView, scale: CGFloat) -> UIView {
    let frame = CGRect(
        x: square.frame.origin.x,
        y: square.frame.origin.y - square.frame.height * scale,
        width: square.frame.width,
        height: square.frame.height * scale)

    return UIView(frame: frame)
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let squareFrame = CGRect(x: 200, y: 300, width: 20, height: 20)
        let square = UIView(frame: squareFrame)
        square.backgroundColor = UIColor.redColor()
        self.view.addSubview(square)

        drawHorizontal(square, scale: 0.9, iteration: 20, hFunc: copyRight, vFunc: copyAbove)
        drawHorizontal(square, scale: 0.9, iteration: 20, hFunc: copyLeft, vFunc: copyBelow)

        drawHorizontal(square, scale: 0.9, iteration: 20, hFunc: copyRight, vFunc: copyBelow)
        drawHorizontal(square, scale: 0.9, iteration: 20, hFunc: copyLeft, vFunc: copyAbove)
    }


    func drawHorizontal(square: UIView, scale: CGFloat, iteration: Int, hFunc: CopyFunc, vFunc: CopyFunc) {
        if iteration > 0 {
            let squareCopy = hFunc(square, scale)

            if iteration % 2 == 0 {
                squareCopy.backgroundColor = UIColor.orangeColor()
            } else {
                squareCopy.backgroundColor = UIColor.redColor()
            }

            self.view.addSubview(squareCopy)

            drawVertical(square, scale: scale, iteration: iteration, vFunc: vFunc)
            drawHorizontal(squareCopy, scale: scale, iteration: iteration - 1, hFunc: hFunc, vFunc: vFunc)
        }
    }


    func drawVertical(square: UIView, scale: CGFloat, iteration: Int, vFunc: CopyFunc) {
        if iteration > 0 {
            let squareCopy = vFunc(square, scale)

            if iteration % 2 == 0 {
                squareCopy.backgroundColor = UIColor.orangeColor()
            } else {
                squareCopy.backgroundColor = UIColor.redColor()
            }

            self.view.addSubview(squareCopy)

            drawVertical(squareCopy, scale: scale, iteration: iteration - 1, vFunc: vFunc)
        }
    }

}

