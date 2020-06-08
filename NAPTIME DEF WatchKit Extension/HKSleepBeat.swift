//
//  HKSleepBeat.swift
//  NAPTIME DEF WatchKit Extension
//
//  Created by Denys Pashkov on 23/01/2020.
//  Copyright © 2020 Denys Pashkov. All rights reserved.
//

import Foundation
import HealthKit

class HKSleepBeat {
        
    let healthStore = HKHealthStore()

    //create an array of HKSample which will hold your data from healthkit or you can create a custom class for that
    var sleepHeartRate: Double?

    init() {
        getHealthKitPermission()
    }

        func getRates(){

            getSleepRate { (result) in
                DispatchQueue.main.async {
                    
                    let heartRateUnit:HKUnit = HKUnit(from: "count/min")
                    guard let currData:HKQuantitySample = result.last as? HKQuantitySample else { 
                        return
                    }
                    
                    self.sleepHeartRate = currData.quantity.doubleValue(for: heartRateUnit)
                    
                }
            }
        }

        //Permission
        func getHealthKitPermission() {
            let healthkitTypesToRead = NSSet(array: [
                HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.restingHeartRate) ?? ""
                ])

            healthStore.requestAuthorization(toShare: nil, read: healthkitTypesToRead as? Set) { (success, error) in
                if success {
                    self.getRates()

                } else {
                    if error != nil {
                        print(error ?? "error")
                    }
                    print("Permission denied.")
                }
            }
        }

        func getSleepRate(completion: (@escaping ([HKSample]) -> Void)) {
            print("func")

            let heartRateType:HKQuantityType = HKQuantityType.quantityType(forIdentifier: .restingHeartRate)!

            //predicate
            let startDate = Date() - 24 * 60 * 60
            let endDate = Date()
            let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: [])
            print(startDate)
            //descriptor
            let sortDescriptors = [
                NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
            ]

            let heartRateQuery = HKSampleQuery(sampleType: heartRateType,
                                               predicate: predicate,
                                               limit: Int(HKObjectQueryNoLimit),
                                               sortDescriptors: sortDescriptors)
            { (query:HKSampleQuery, results:[HKSample]?, error:Error?) -> Void in

                guard error == nil else { print("error"); return }

                //Here I have added completion which will pass data when button will tap.
                completion(results!)

            }
            healthStore.execute(heartRateQuery)

        }
    
}


