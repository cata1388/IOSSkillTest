//
//  Artist.swift
//  IOSSkillTest
//
//  Created by Catalina Sanchez Castaño on 1/30/16.
//  Copyright © 2016 Catalina Sanchez Castaño. All rights reserved.
//

import UIKit

class Artist: NSObject {
	
	let id: String
	let name: String
	let followers: Int
	let popularity: Int
	let imageURL: NSURL
	let albums: [Album]
	
	
	init(id: String, name: String, followers: Int, popularity: Int, imageURL: NSURL, albums: [Album]) {
		
		self.id = id
		self.name = name
		self.followers = followers
		self.popularity = popularity
		self.imageURL = imageURL
		self.albums = albums
		
	}
	
	class func searchArtistWithName(name: String, completion: (artist: Artist?, error: String?) -> Void) {
		
		let sessionManager = SessionManager.sharedInstance
		let searchPath = "search"
		var parameters = [String: AnyObject]()
		
		parameters["q"] = name
		parameters["type"] = "artist"
		
		
		sessionManager.GET(searchPath, parameters: parameters,
			success: { (_, response) -> Void in
				guard let json = response as? [String: AnyObject],
					artists = json["artists"] as? [String: AnyObject],
					items = artists["items"] as? [AnyObject]
					else {
						completion(artist: nil, error: "something went wrong")
						return
				}
				
				guard let item = items.first as? [String: AnyObject],
					name = item["name"] as? String,
					id = item["id"] as? String,
					popularity = item["popularity"] as? Int,
					image = item["images"] as? [AnyObject],
					contentImage = image.first as? [String: AnyObject],
					imageURL = contentImage["url"] as? String,
					followers = item["followers"] as? [String: AnyObject],
					totalFollowers = followers["total"] as? Int
					else {
						completion(artist: nil, error: "no data founded")
						return
				}
				
				Album.loadAlbums(id, completion: { (albums, error) -> Void in
					
					if let error = error {
						completion(artist: nil, error: error)
					}
					
					if let albums = albums {
						let artist = Artist(id: id, name: name, followers: totalFollowers, popularity: popularity, imageURL: NSURL(string: imageURL) ?? NSURL(), albums: albums)
						completion(artist: artist, error: nil)
					}
				})
				
				
			}, failure: { (_, error) -> Void in
				completion(artist: nil, error: error.localizedDescription)
				
				
		})
				
	}
	
		
}
