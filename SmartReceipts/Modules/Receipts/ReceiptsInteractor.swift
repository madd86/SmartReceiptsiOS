//
//  ReceiptsInteractor.swift
//  SmartReceipts
//
//  Created by Bogdan Evsenev on 18/06/2017.
//  Copyright © 2017 Will Baumann. All rights reserved.
//

import Foundation
import Viperit
import RxSwift

class ReceiptsInteractor: Interactor {
    
    var fetchedModelAdapter: FetchedModelAdapter!
    var trip: WBTrip!
    
    private let bag = DisposeBag()
    
    func configureSubscribers() {
        presenter.receiptDeleteSubject.subscribe( onNext: { receipt in
            AnalyticsManager.sharedManager.record(event: Event.receiptsReceiptMenuDelete())
            Database.sharedInstance().delete(receipt)
        }).disposed(by: bag)
    }
    
    func distanceReceipts() -> [WBReceipt] {
        let distances = Database.sharedInstance().fetchedAdapterForDistances(in: trip, ascending: true)
        return DistancesToReceiptsConverter.convertDistances(distances!.allObjects()) as! [WBReceipt]
    }
    
    func nextID() -> String {
        let id = Database.sharedInstance().nextAutoGeneratedID(forTable: ReceiptsTable.Name)
        return String(format: LocalizedString("trips.controller.next.id.subtitle"), "\(id)")
    }
    
    func fetchedAdapter(for trip: WBTrip) -> FetchedModelAdapter {
        fetchedModelAdapter = Database.sharedInstance().fetchedReceiptsAdapter(for: trip)
        return fetchedModelAdapter
    }
    
    func swapUpReceipt(_ receipt: WBReceipt) {
        let idx = Int(fetchedModelAdapter.index(for: receipt))
        if idx == 0 || idx == NSNotFound {
            return
        }
        swapReceipt(idx1: idx, idx2: idx - 1)
    }
    
    func swapDownReceipt(_ receipt: WBReceipt) {
        let idx = Int(fetchedModelAdapter.index(for: receipt))
        if idx >= Int(fetchedModelAdapter.numberOfObjects()) - 1 || idx == NSNotFound {
            return
        }
        swapReceipt(idx1: idx, idx2: idx + 1)
    }
    
    private func swapReceipt(idx1: Int, idx2: Int) {
        let rec1 = fetchedModelAdapter.object(at: idx1) as! WBReceipt
        let rec2 = fetchedModelAdapter.object(at: idx2) as! WBReceipt
        
        if (!Database.sharedInstance().swapReceipt(rec1, with: rec2)) {
            Logger.warning("Error: Cannot Swap")
        }
    }
    
}

// MARK: - VIPER COMPONENTS API (Auto-generated code)
private extension ReceiptsInteractor {
    var presenter: ReceiptsPresenter {
        return _presenter as! ReceiptsPresenter
    }
}
