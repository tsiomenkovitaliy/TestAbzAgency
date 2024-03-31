//
//  AppDelegate.swift
//  TestAbzAgency
//
//  Created by Vitalii Tsiomenko on 27.03.2024.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		return true
	}

	// MARK: UISceneSession Lifecycle

	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		// Called when a new scene session is being created.
		// Use this method to select a configuration to create the new scene with.
		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}

	func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
		// Called when the user discards a scene session.
		// If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
		// Use this method to release any resources that were specific to the discarded scenes, as they will not return.
	}

	// MARK: - Core Data stack
	
	lazy var persistentCoordinator: NSPersistentStoreCoordinator = {
			
		let modelURL = Bundle.main.url(forResource: "TestAbzAgency", withExtension: "momd")
		let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL!)
		let persistentCoordinator = NSPersistentStoreCoordinator(managedObjectModel:
												managedObjectModel!)
		let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
												.userDomainMask, true)[0]
		let storeURL = URL(fileURLWithPath: documentsPath.appending("/TestAbzAgency.sqlite"))
		print("storeUrl = \(storeURL)")
		do {
			try persistentCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
												 configurationName: nil,
												 at: storeURL,
												 options: [NSSQLitePragmasOption:
															  ["journal_mode":"MEMORY"]])
			return persistentCoordinator
		} catch {
			abort()
		}
	} ()


	lazy var managedObjectContext: NSManagedObjectContext = {
	    /*
	     The persistent container for the application. This implementation
	     creates and returns a container, having loaded the store for the
	     application to it. This property is optional since there are legitimate
	     error conditions that could cause the creation of the store to fail.
	    */
		let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
		managedObjectContext.persistentStoreCoordinator = persistentCoordinator
//	    let container = NSPersistentContainer(name: "TestAbzAgency")
//	    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//	        if let error = error as NSError? {
//	            fatalError("Unresolved error \(error), \(error.userInfo)")
//	        }
//	    })
	    return managedObjectContext
	}()

	// MARK: - Core Data Saving support

	func saveContext () {
		let context = managedObjectContext
	    if context.hasChanges {
	        do {
	            try context.save()
	        } catch {
	            // Replace this implementation with code to handle the error appropriately.
	            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
	            let nserror = error as NSError
	            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
	        }
	    }
	}
}

