//
//  CoreData.swift
//  Qadmni
//
//  Created by Prakash Sabale on 15/02/17.
//  Copyright © 2017 Qadmni. All rights reserved.
//

import Foundation
import UIKit
import CoreData

public class CoreData
{
        // MARK: - Core Data stack
        public static let sharedInstance = CoreData()
    
    
    public func storeUserData (cartModel : MyCartModel) {
        
        let managedObjectContext: NSManagedObjectContext = getManagedObjectContext()

        do{
            let fetchRequest: NSFetchRequest<User>=User.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "productId == %ld", cartModel.productId)
            let searchResult=try managedObjectContext.fetch(fetchRequest)
            if(!searchResult.isEmpty)            {
                let oldUser : User=searchResult[0]
                if(cartModel.productQuantity==0)
                {
                    managedObjectContext.delete(oldUser)
                }
                else{
                    oldUser.productQuantity=cartModel.productQuantity
                    oldUser.unitPrice=cartModel.unitPrice
                }
                
            }
            else{
                if(cartModel.productQuantity==0){
                    print("Nothing to do quantity is empty")
                }
                else
                {
                    //retrieve the entity that we just created
                    let entity =  NSEntityDescription.entity(forEntityName: "User", in: managedObjectContext)
                    
                    let userDetail = NSManagedObject(entity: entity!, insertInto: managedObjectContext)
                    
                    //set the entity values
                    userDetail.setValue(cartModel.producerId, forKey: "producerId")
                    userDetail.setValue(cartModel.productId, forKey: "productId")
                    userDetail.setValue(cartModel.productName, forKey: "productName")
                    userDetail.setValue(cartModel.productQuantity, forKey: "productQuantity")
                    userDetail.setValue(cartModel.unitPrice, forKey: "unitPrice")

                }
                }
            
        }catch{
            print("Error with request: \(error)")
        }
        
            //save the object
            do {
                try managedObjectContext.save()
                print("saved!")
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            } catch {
                
            }
        }
    
    
    func getUserCoreDataDetails () -> [MyCartModel] {
        //create a fetch request, telling it about the entity
        var cartList : [MyCartModel] = []
        
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            //go get the results
            let searchResults = try getManagedObjectContext().fetch(fetchRequest)
            
            //I like to check the size of the returned results!
            print ("num of results = \(searchResults.count)")
            
            //You need to convert to NSManagedObject to use 'for' loops
            for userDetail in searchResults as [NSManagedObject] {
                //get the Key Value pairs (although there may be a better way to do that...
                print("\(userDetail.value(forKey: "productName"))")
                let mycart = MyCartModel()
                mycart.productId = userDetail.value(forKey: "productId") as! Int32
                mycart.producerId = userDetail.value(forKey: "producerId") as! Int32
                mycart.productName = userDetail.value(forKey: "productName") as! String
                mycart.productQuantity = userDetail.value(forKey: "productQuantity") as! Int16
                mycart.unitPrice = userDetail.value(forKey: "unitPrice") as! Double
                cartList.append(mycart)
                
            }
        
        } catch {
            print("Error with request: \(error)")
        }
        
        return cartList
    }
    
    
    func getCustomerItemInfo () -> [ItemRequestModel] {
        //create a fetch request, telling it about the entity
        var itemInfoList : [ItemRequestModel] = []
        
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            //go get the results
            let searchResults = try getManagedObjectContext().fetch(fetchRequest)
            
            //I like to check the size of the returned results!
            print ("num of results = \(searchResults.count)")
            
            //You need to convert to NSManagedObject to use 'for' loops
            for userDetail in searchResults as [NSManagedObject] {
                //get the Key Value pairs (although there may be a better way to do that...
              
                let itemInfo  = ItemRequestModel()
                itemInfo.itemId = userDetail.value(forKey: "productId") as! Int32
                itemInfo.itemQty = userDetail.value(forKey: "productQuantity") as! Int
                
                itemInfoList.append(itemInfo)
                
            }
            
        } catch {
            print("Error with request: \(error)")
        }
        
        return itemInfoList
    }
    
    func getItemQuantity(itemId : Int32) -> Int32
    {
        var quantity : Int32 = 0
        let managedObjectContext: NSManagedObjectContext = getManagedObjectContext()
        do{
            let fetchRequest: NSFetchRequest<User>=User.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "productId == %ld", itemId)
            let searchResult=try managedObjectContext.fetch(fetchRequest)
            if(!searchResult.isEmpty)            {
                let oldUser : User=searchResult[0]
                quantity = Int32(oldUser.productQuantity)
                
            }
            
        }catch{
            print("Error with request: \(error)")
        }
        return quantity
    }
    
    func deleteCartData()
    {
        let managedObjectContext: NSManagedObjectContext = getManagedObjectContext()
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        do {
            let searchResults = try managedObjectContext.fetch(fetchRequest)
            for userDetail in searchResults as [NSManagedObject] {
                managedObjectContext.delete(userDetail)
               
            }
        }catch {
            print("Error with request: \(error)")
        }
        do {
            try managedObjectContext.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }

    }
    func saveUserFavourites(myfavourites : MyFavouritesModel)
    {
        let managedObjectContext: NSManagedObjectContext = getManagedObjectContext()
        do{
            
        let entity =  NSEntityDescription.entity(forEntityName: "Favourites", in: managedObjectContext)
        let userfavourite = NSManagedObject(entity: entity!, insertInto: managedObjectContext)
        userfavourite.setValue(myfavourites.itemId, forKey: "itemId")
    
        }catch{
        print("Error with request: \(error)")
        }
        
        //save the object
        do {
            try managedObjectContext.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
    
    }
    func isMyfavourites(itemId : Int32)->Bool
    {
        var isFavourite : Bool = false
        let managedObjectContext: NSManagedObjectContext = getManagedObjectContext()
        do{
            let fetchRequest: NSFetchRequest<Favourites>=Favourites.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "itemId == %ld", itemId)
            let searchResult=try managedObjectContext.fetch(fetchRequest)
            if(!searchResult.isEmpty){
            isFavourite = true
            }else{
            isFavourite = false
            }
            
        }catch{
            print("Error with request: \(error)")
        }
        return isFavourite
    }
    
    func deleteMyFavourite()
    {
        let managedObjectContext: NSManagedObjectContext = getManagedObjectContext()
        let fetchRequest: NSFetchRequest<Favourites> = Favourites.fetchRequest()
        do {
            let searchResults = try managedObjectContext.fetch(fetchRequest)
            for userfavourite in searchResults as [NSManagedObject] {
                managedObjectContext.delete(userfavourite)
                
            }
        }catch {
            print("Error with request: \(error)")
        }
        do {
            try managedObjectContext.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
        
    }
    
    
    func deletemyFavouriteItem(itemId : Int32)
    {
        let managedObjectContext: NSManagedObjectContext = getManagedObjectContext()
        do{
        let fetchRequest: NSFetchRequest<Favourites>=Favourites.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "itemId == %ld", itemId)
        let searchResult=try managedObjectContext.fetch(fetchRequest)
        if(!searchResult.isEmpty){
            let favItem : Favourites=searchResult[0]
            managedObjectContext.delete(favItem)
            }}catch{
                print("Error to delete data \(error)")
        }
            
        do {
            try managedObjectContext.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
        
    }
    


    
        // MARK: - Core Data stack
        
        func getApplicationDocumentsDirectory() -> NSURL {
            // The directory the application uses to store the Core Data store file. This code uses a directory named "uk.co.plymouthsoftware.core_data" in the application's documents Application Support directory.
            let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            return urls[urls.count-1] as NSURL
        }
        
        func getManagedObjectModel() -> NSManagedObjectModel {
            // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
            
            let modelURL = Bundle.main.url(forResource: "Qadmni", withExtension: "momd")!
            return NSManagedObjectModel(contentsOf: modelURL)!
        }
        
        func getPersistentStoreCoordinator() -> NSPersistentStoreCoordinator {
            // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
            // Create the coordinator and store
            
            // Creating Application document directory
            let appDocDirectory: NSURL = getApplicationDocumentsDirectory()
            
            // Creating managed object model
            let managedObjModel: NSManagedObjectModel = getManagedObjectModel()
            
            let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjModel)
            let url = appDocDirectory.appendingPathComponent("vbtestproject.sqlite")
            let failureReason = "There was an error creating or loading the application's saved data."
            do {
                try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
            } catch {
                // Report any error we got.
                var dict = [String: AnyObject]()
                dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
                dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
                
                dict[NSUnderlyingErrorKey] = error as NSError
                let wrappedError = NSError(domain: "vibeosys.com", code: 9999, userInfo: dict)
                // Replace this with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
                abort()
            }
            
            return coordinator
        }
        
        func getManagedObjectContext() -> NSManagedObjectContext {
            // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
            let coordinator = getPersistentStoreCoordinator()
            let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
            managedObjectContext.persistentStoreCoordinator = coordinator
            return managedObjectContext
        }
        
        // MARK: - Core Data Saving support
        
        func saveContext () {
            if getManagedObjectContext().hasChanges {
                do {
                    try getManagedObjectContext().save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nserror = error as NSError
                    NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                    abort()
                } //End of catch
            }//End of Id
        }// end of function
}// end of class

/*    private lazy var applicationDocumentsDirectory: URL = {
 // The directory the application uses to store the Core Data store file. This code uses a directory named in the application's documents Application Support directory.
 
 let urls = FileManager.urls(for: .documentDirectory, in: .userDomainMask)
 return urls[urls.count-1]
 }()
 
 private lazy var managedObjectModel: NSManagedObjectModel = {
 // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
 let modelURL = NSBundle..url(forResource: "CoreDataSwift", withExtension: "momd")!
 return NSManagedObjectModel(contentsOf: modelURL)!
 }()
 
 lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
 // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
 // Create the coordinator and store
 let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
 let url = self.applicationDocumentsDirectory.appendingPathComponent("CoreDataSwift.sqlite")
 var failureReason = "There was an error creating or loading the application's saved data."
 do {
 // Configure automatic migration.
 let options = [ NSMigratePersistentStoresAutomaticallyOption : true, NSInferMappingModelAutomaticallyOption : true ]
 try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: options)
 } catch {
 // Report any error we got.
 var dict = [String: AnyObject]()
 dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
 dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
 
 dict[NSUnderlyingErrorKey] = error as NSError
 let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
 // Replace this with code to handle the error appropriately.
 // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
 NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
 abort()
 }
 
 return coordinator
 }()
 
 lazy var managedObjectContext: NSManagedObjectContext = {
 
 var managedObjectContext: NSManagedObjectContext?
 if #available(iOS 10.0, *){
 
 managedObjectContext = self.persistentContainer.viewContext
 }
 else{
 // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
 let coordinator = self.persistentStoreCoordinator
 managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
 managedObjectContext?.persistentStoreCoordinator = coordinator
 
 }
 return managedObjectContext!
 }()
 
 
}*/

