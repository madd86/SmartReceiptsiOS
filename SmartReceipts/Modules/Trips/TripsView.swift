//
//  TripsView.swift
//  SmartReceipts
//
//  Created by Bogdan Evsenev on 11/06/2017.
//  Copyright © 2017 Will Baumann. All rights reserved.
//

import UIKit
import Viperit
import RxSwift

//MARK: - Public Interface Protocol
protocol TripsViewInterface {
    var settingsButton: UIBarButtonItem { get }
    var addButton: UIBarButtonItem { get }
}

//MARK: Trips View
final class TripsView: FetchedCollectionViewControllerSwift {
    
    @IBOutlet fileprivate weak var _settingsButton: UIBarButtonItem!
    @IBOutlet fileprivate weak var _addButton: UIBarButtonItem!
    
    private var priceWidth: CGFloat = 0
    private let dateFormatter = WBDateFormatter()
    private var lastDateSeparator: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AppTheme.customizeOnViewDidLoad(self)
        setPresentationCellNib(WBCellWithPriceNameDate.viewNib())
        
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        self.toolbarItems = [space, editButtonItem]
        
        NotificationCenter.default.addObserver(self, selector: #selector(settingsSaved),
                        name: NSNotification.Name.SmartReceiptsSettingsSaved, object: nil)
        lastDateSeparator = WBPreferences.dateSeparator()
        editButtonItem.image = #imageLiteral(resourceName: "edit-2")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func settingsSaved() {
        if lastDateSeparator == WBPreferences.dateSeparator() {
            return
        }
        lastDateSeparator = WBPreferences.dateSeparator()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateEditButton()
    }
    
    func updateEditButton() {
        editButtonItem.isEnabled = numberOfItems() > 0
    }
    
    override var placeholderTitle: String {
        get { return LocalizedString("fetched.placeholder.trips.title") }
    }

    override func createFetchedModelAdapter() -> FetchedModelAdapter? {
        return presenter.fetchedModelAdapter()
    }
    
    private func updatePricesWidth() {
        let w = computePriceWidth()
        if w == priceWidth {
            return
        }
        priceWidth = w
        for cell in tableView.visibleCells {
            if let pCell = cell as? WBCellWithPriceNameDate {
                pCell.priceWidthConstraint.constant = w
                pCell.layoutIfNeeded()
            }
        }
    }
    
    private func computePriceWidth() -> CGFloat {
        var maxWidth: CGFloat = 0
        
        for i in 0..<numberOfItems() {
            let trip = objectAtIndexPath(IndexPath(row: i, section: 0)) as! WBTrip
            var formattedPrice = trip.formattedPrice()
            
            // Victor:
            // In some cases WBTrip.pricesSummary becomes nil (say, when we removed any trip in this VC), actually it has been re-initialized without refresing 'pricesSummary'
            // lines below solving the problem without breaking something else (as I afraid to do so)
            if formattedPrice == nil {
                Database.sharedInstance().refreshPriceForTrip(trip)
                formattedPrice = trip.formattedPrice()
            }
            let b = (formattedPrice! as NSString).boundingRect(with: CGSize(width: 1000, height: 100),
                options: .usesDeviceMetrics, attributes: [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 21)], context: nil)
            maxWidth = max(maxWidth, b.width + 10)
        }
        
        let priceLabelSpacing: CGFloat = 16
        let priceToNameSpacing: CGFloat = 12
        
        return min((view.bounds.width - priceLabelSpacing * 2 - priceToNameSpacing)/2, maxWidth)
    }
    
    override func configureCell(_ cell: UITableViewCell, indexPath: IndexPath, object: Any) {
        let pCell = cell as! WBCellWithPriceNameDate
        let trip = object as! WBTrip
        
        pCell.priceField.text = trip.formattedPrice()
        pCell.nameField.text = trip.name
        pCell.dateField.text = String(format: LocalizedString("trips.controller.from.to.date.label.base"),
            dateFormatter.formattedDate(trip.startDate, in: trip.startTimeZone),
            dateFormatter.formattedDate(trip.endDate, in: trip.endTimeZone))
        pCell.priceWidthConstraint.constant = priceWidth
    }
    
    override func delete(object: Any!, at indexPath: IndexPath) {
        presenter.tripDeleteSubject.onNext(object as! WBTrip)
    }
    
    override func tappedObject(_ tapped: Any, indexPath: IndexPath) {
        let trip = tapped as! WBTrip
        isEditing ? presenter.tripEditSubject.onNext(trip) : presenter.tripDetailsSubject.onNext(trip)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            self.reloadData()
        }
    }
    
    override func contentChanged() {
        updatePricesWidth()
        updateEditButton()
    }
    
    override func didInsert(_ object: Any!, at index: UInt) {
        super.didInsert(object, at: index)
        presenter.tripDetailsSubject.onNext(object as! WBTrip)
    }
}

extension TripsView: UISplitViewControllerDelegate {

}

//MARK: - Public interface
extension TripsView: TripsViewInterface {
    var settingsButton: UIBarButtonItem { get { return _settingsButton } }
    var addButton: UIBarButtonItem { get { return _addButton } }
}

// MARK: - VIPER COMPONENTS API (Auto-generated code)
private extension TripsView {
    var presenter: TripsPresenter {
        return _presenter as! TripsPresenter
    }
    var displayData: TripsDisplayData {
        return _displayData as! TripsDisplayData
    }
}
