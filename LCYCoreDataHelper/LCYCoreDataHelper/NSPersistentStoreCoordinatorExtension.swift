
//
//  NSPersistentStoreCoordinatorExtension.swift
//  LCYCoreDataHelper
//
//  Created by LiChunyu on 16/1/24.
//  Copyright © 2016年 leacode. All rights reserved.
//

import CoreData

extension NSPersistentStoreCoordinator {
    
    /**
     Synchronously exexcutes a given function on the coordinator's internal
     queue.
     
     - attention: This method may safely be called reentrantly.
     - parameter body: The method body to perform on the reciever.
     - returns: The value returned from the inner function.
     - throws: Any error thrown by the inner function. This method should be
     technically `rethrows`, but cannot be due to Swift limitations.
     **/
    public func performAndWaitOrThrow<Return>(_ body: @escaping () throws -> Return) throws -> Return {
        var result: Return!
        var thrown: Error?
        
        performAndWait {
            do {
                result = try body()
            } catch {
                thrown = error
            }
        }
        
        if let thrown = thrown {
            throw thrown
        } else {
            return result
        }
    }

}
