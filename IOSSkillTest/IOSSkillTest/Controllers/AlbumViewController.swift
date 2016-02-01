//
//  AlbumViewController.swift
//  IOSSkillTest
//
//  Created by Catalina Sanchez Castaño on 1/31/16.
//  Copyright © 2016 Catalina Sanchez Castaño. All rights reserved.
//

import UIKit

class AlbumViewController: UIViewController {

	@IBOutlet weak var albumImage: UIImageView!
	
	var album: Album? = nil
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		title = "Album"
		
		if let album = album {
			albumImage.setImageWithURL(album.imageURL)
		}

    }
    

	@IBAction func spotifyLinkTouchUpInside(sender: AnyObject) {
		if let album = album {
			UIApplication.sharedApplication().openURL(album.externalURL)

		}
	}

	
}
