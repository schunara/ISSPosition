//
//  LocationViewModel.swift
//  ISSPosition
//
//  Created by Shashi Chunara on 11/08/22.
//

import Foundation

class LocationViewModel: NSObject {
    //MARK: Public variables
    var bindViewModelToController: (() -> ()) = {}
    
    //MARK: Private variables
    private var timer = Timer()
    private var failureCount = 0
    private(set) var location: Location? {
        didSet {
            self.bindViewModelToController()
        }
    }
    
    //MARK: Initialize
    override init() {
        super.init()
        self.location = nil
        callAPIToGetLocation()
        timer = Timer.scheduledTimer(
            withTimeInterval: 3.0,
            repeats: true,
            block: {[weak self] _ in
                self?.callAPIToGetLocation()
            })
    }
    
    //MARK: User defined methods
    /**
     Get Location of Space Station
    */
    func callAPIToGetLocation() {
        APIService.shared().getLocationWithCompletion {[weak self] (locstionInfo: [AnyHashable : Any]) in
            self?.failureCount = 0
            if let locDict = locstionInfo as? [String: Any] {
                self?.location = Location(response: locDict)
            }
        } failure: {[weak self] (error) in
            self?.failureCount += 1
            if self?.failureCount == 3 {
                self?.timer.invalidate()
            }
            print(error)
        }
    }
}
