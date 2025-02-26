// InstructionsRootView.swift
//
// Copyright (c) 2016, 2017 Frédéric Maquin <fred@ephread.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

internal protocol PassthroughViewDelegate {
    func onPassthoughViewClicked()
}

class InstructionsWindow: UIWindow {
    override init(frame: CGRect) {
        super.init(frame: frame)
        accessibilityIdentifier = AccessibilityIdentifiers.window
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        accessibilityIdentifier = AccessibilityIdentifiers.window
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)

        if hitView == self {
            return nil
        }

        return hitView
    }
}

class PassthroughView: UIView {
    var delegate: PassthroughViewDelegate?
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)

        if hitView == self {
            delegate?.onPassthoughViewClicked()
            return nil
        }

        return hitView
    }
}

/// Top view added to the window, forwarding touch events.
class InstructionsRootView: UIView {

    var passthrough: Bool = false

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)

        if hitView == self && passthrough {
            return nil
        }

        return hitView
    }
}
