//
//  Album.swift
//  IOSSkillTest
//
//  Created by Catalina Sanchez Castaño on 1/30/16.
//  Copyright © 2016 Catalina Sanchez Castaño. All rights reserved.
//

import UIKit

class Album: NSObject {
	
	let id: String
	let imageURL: NSURL
	let name: String
	let available: [String]
	let externalURL: NSURL
	
	init(id: String, imageURL: NSURL, name: String, available: [String], externalURL: NSURL) {
		
		self.id = id
		self.imageURL = imageURL
		self.name = name
		self.available = available
		self.externalURL = externalURL
		
	}
	
	class func loadAlbums(id: String, completion: (albums: [Album]?, error: String?) -> Void) {
		
		let sessionManager = SessionManager.sharedInstance
		let searchPath = "artists/\(id)/albums"
		
		sessionManager.GET(searchPath, parameters: nil,
			success: { (_, response) -> Void in
				var albums = [Album]()
				
				guard let json = response as? [String: AnyObject],
					items = json["items"] as? [AnyObject]
					else {
						completion(albums: nil, error: "something went wrong")
						return
				}
				
				for item in items {
					guard let contentItem = item as? [String: AnyObject],
						id = contentItem["id"] as? String,
						name = contentItem["name"] as? String,
						images = contentItem["images"] as? [AnyObject],
						contentImages = images.first as? [String: AnyObject],
						imageURL = contentImages["url"] as? String,
						availability = contentItem["available_markets"] as? [String],
						externalURLs = contentItem["external_urls"] as? [String: AnyObject],
						externalURL = externalURLs["spotify"] as? String
						else {
							completion(albums: nil , error: "no data founded")
							return
					}
					let album = Album(id: id, imageURL: NSURL(string: imageURL) ?? NSURL(), name: name, available: availability, externalURL: NSURL(string: externalURL) ?? NSURL())
					albums.append(album)
					
				}
				
				completion(albums: albums, error: nil)
			}) { (_, error) -> Void in
				completion(albums: nil, error: error.localizedDescription)
		}
	}
	
	
}
