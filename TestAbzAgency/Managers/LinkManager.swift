//
//  LinkManager.swift
//  TestAbzAgency
//
//  Created by Vitalii Tsiomenko on 31.03.2024.
//

import Foundation

final class LinkManager {
	
	static let shared = LinkManager()
	
	func processURL(_ url: URL) {
		guard let urlComponent = URLComponents(url: url, resolvingAgainstBaseURL: false),
			  let host = urlComponent.host,
			  host.contains("google.com") else {
			print("URL is not from google.com")
			return
		}
		
		let queryItems = urlComponent.queryItems
		guard let queryValue = queryItems?.first(where: { $0.name == "q" })?.value else {
			print("Key 'q' not found in query parameters")
			return
		}
		
		CoreDataManager.shared.saveRequest(urlString: url.absoluteString, text: queryValue)
	}
}
