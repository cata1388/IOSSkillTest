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
	
	

}
