//
//  Constants.swift
//  SmartReceipts
//
//  Created by Jaanus Siim on 16/05/16.
//  Copyright © 2016 Will Baumann. All rights reserved.
//

import Foundation
import QuartzCore

func onMainThread(_ closure: @escaping () -> ()) {
    DispatchQueue.main.async(execute: closure)
}

func timeMeasured(_ desc: String = "", closure: () -> ()) {
    let start = CACurrentMediaTime()
    closure()
    Logger.debug(String(format: "%@ - time: %f", desc, CACurrentMediaTime() - start))
}

func delayedExecution(_ afterSecons: TimeInterval, closure: @escaping () -> ()) {
    let delayTime = DispatchTime.now() + Double(Int64(afterSecons * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
    DispatchQueue.main.asyncAfter(deadline: delayTime, execute: closure)
}

func LocalizedString(_ key: String, comment: String = "") -> String {
    return NSLocalizedString(key, comment: comment)
}

func MainStoryboard() -> UIStoryboard {
    return UI_USER_INTERFACE_IDIOM() == .pad ?
        UIStoryboard(name: "MainStoryboard_iPad", bundle: nil) :
        UIStoryboard(name: "MainStoryboard_iPhone", bundle: nil)
}

func executeFor(iPhone: ()->(), iPad: ()->()) {
    UI_USER_INTERFACE_IDIOM() == .pad ? iPad() : iPhone()
}

enum ReceiptAttachmentType {
    case image
    case pdf
    case none
}
