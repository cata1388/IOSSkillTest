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
	
	init(id: String, imageURL: NSURL, name: String, available: [String]) {
		
		self.id = id
		self.imageURL = imageURL
		self.name = name
		self.available = available
		
	}

}
