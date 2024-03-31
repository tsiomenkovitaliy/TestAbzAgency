import Foundation
import CoreData

class RequestViewModel {
	private let dataManager: CoreDataManager
	
	var requests: [Request] = []
	var delegate: RequestViewModelDelegate!
	
	init(dataManager: CoreDataManager) {
		self.dataManager = dataManager
		dataManager.delegate = self
	}
	
	func fetchRequests(completion: @escaping () -> Void) {
		dataManager.fetchRequests { requests in
			self.requests = requests
			completion()
		}
	}
	
	func deleteRequest(at index: Int, completion: @escaping () -> Void) {
		let request = requests[index]
		dataManager.managedContext.delete(request)
		do {
			try dataManager.managedContext.save()
			requests.remove(at: index)
			completion()
		} catch let error as NSError {
			print("Could not delete. \(error), \(error.userInfo)")
		}
	}
}

extension RequestViewModel: CoreDataManagerDelegate {
	func dataIsSaved() {
		delegate.requestsUpdated()
	}
}
