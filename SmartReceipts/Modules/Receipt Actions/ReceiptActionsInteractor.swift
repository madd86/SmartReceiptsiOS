//
//  ReceiptActionsInteractor.swift
//  SmartReceipts
//
//  Created by Bogdan Evsenev on 18/06/2017.
//  Copyright © 2017 Will Baumann. All rights reserved.
//

import Foundation
import Viperit

class ReceiptActionsInteractor: Interactor {
    
    func attachAppInputFile(to receipt: WBReceipt) -> Bool {
        let result = processAttachFile(to: receipt)
        WBAppDelegate.instance().freeFilePathToAttach()
        return result
    }
    
    func attachImage(_ image: UIImage, to receipt: WBReceipt) -> Bool {
        let imageFileName = String(format: "%tu_%@.jpg", receipt.receiptId(), receipt.name)
        let path = receipt.trip.file(inDirectoryPath: imageFileName)
        if !WBFileManager.forceWrite(UIImageJPEGRepresentation(image, 0.85), to: path!) {
            return false
        }
        
        if !Database.sharedInstance().update(receipt, changeFileNameTo: imageFileName) {
            Logger.error("Error: cannot update image file")
            return false
        }
        return true
    }
    
    private func processAttachFile(to receipt: WBReceipt) -> Bool {
        let file = WBAppDelegate.instance().filePathToAttach!
        let ext = (file as NSString).pathExtension
        
        let imageFileName = String(format: "%tu_%@.%@", receipt.receiptId(), receipt.name, ext)
        let newFile = receipt.trip.file(inDirectoryPath: imageFileName)
        
        if !WBFileManager.forceCopy(from: file, to: newFile) {
            Logger.error("Couldn't force copy from \(file) to \(newFile!)")
            return false
        }
        
        if !Database.sharedInstance().update(receipt, changeFileNameTo: imageFileName) {
            Logger.error("Error: cannot update image file \(imageFileName) for receipt \(receipt.name)")
            return false
        }
        return true
    }
}

// MARK: - VIPER COMPONENTS API (Auto-generated code)
private extension ReceiptActionsInteractor {
    var presenter: ReceiptActionsPresenter {
        return _presenter as! ReceiptActionsPresenter
    }
}
