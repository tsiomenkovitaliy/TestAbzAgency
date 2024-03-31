//
//  CoreDataManager.swift
//  TestAbzAgency
//
//  Created by Vitalii Tsiomenko on 30.03.2024.
//

import Foundation
import CoreData
import UIKit

protocol CoreDataManagerDelegate {
	func dataIsSaved()
}

final class CoreDataManager {
	
	static let shared = CoreDataManager()
	
	var managedContext: NSManagedObjectContext!
	var delegate: CoreDataManagerDelegate?
	
	init() {
		setupCoreDataStack()
	}
	
	// MARK: - Private Func
	
	private func setupCoreDataStack() {
		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
		
		managedContext = appDelegate.managedObjectContext
	}
	
	func saveRequest(urlString: String, text: String) {
		let entity = NSEntityDescription.entity(forEntityName: "Request", in: managedContext)!
		let request = NSManagedObject(entity: entity, insertInto: managedContext)
		request.setValue(text, forKey: "text")
		request.setValue(Date(), forKey: "timestamp")
		
		do {
			try managedContext.save()
			delegate?.dataIsSaved()
		} catch let error as NSError {
			print("Could not save. \(error), \(error.userInfo)")
		}
	}
	
	func fetchRequests(complited: @escaping ([Request])->()) {
		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Request")
		do {
			if let results = try managedContext.fetch(fetchRequest) as? [Request] {
				complited(results)
			}
		} catch let error as NSError {
			print("Could not fetch. \(error), \(error.userInfo)")
		}
	}
}
