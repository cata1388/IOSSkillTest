//
//  ArtistSearchViewController.swift
//  IOSSkillTest
//
//  Created by Catalina Sanchez Castaño on 1/31/16.
//  Copyright © 2016 Catalina Sanchez Castaño. All rights reserved.
//

import UIKit
import SVProgressHUD
import AFNetworking

class ArtistSearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

	@IBOutlet weak var searchArtistTextField: UITextField!
	@IBOutlet weak var resultLabel: UILabel!
	@IBOutlet weak var artistInformationStack: UIStackView!
	@IBOutlet weak var artistImage: UIImageView!
	@IBOutlet weak var artistNameLabel: UILabel!
	@IBOutlet weak var artistFollowers: UILabel!
	@IBOutlet weak var artistPopularity: UILabel!
	@IBOutlet weak var albumsLabel: UILabel!
	@IBOutlet weak var albumsTableView: UITableView!
	
	var artist: Artist? = nil
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		showData()
		albumsTableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
	
	private func showData() {
		if let _ = artist {
			resultLabel.hidden = false
			albumsLabel.hidden = false
			artistInformationStack.hidden = false
			albumsTableView.hidden = false
		} else {
			resultLabel.hidden = true
			albumsLabel.hidden = true
			artistInformationStack.hidden = true
			albumsTableView.hidden = true
		}
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	
	@IBAction func searchActionTouchUpInside(sender: AnyObject) {
		let name = searchArtistTextField.text
		SVProgressHUD.show()
		Artist.searchArtistWithName(name ?? "") { (artist, error) -> Void in
			
			SVProgressHUD.dismiss()
			if let error = error {
				SVProgressHUD.showErrorWithStatus(error)
			}
			
			if let artist = artist {
				self.artist = artist
				self.artistImage.setImageWithURL(artist.imageURL)
				self.artistNameLabel.text = artist.name
				self.artistFollowers.text = "\(artist.followers)"
				self.artistPopularity.text = "\(artist.popularity)"
			}
			
			self.showData()
			self.albumsTableView.reloadData()
		}
		
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCellWithIdentifier("cellId", forIndexPath: indexPath) as! CustomCellTableViewCell
		
		if let artist = artist {
			cell.albumImage.setImageWithURL(artist.albums[indexPath.row].imageURL)
			cell.albumNameLabel.text = artist.albums[indexPath.row].name
			if artist.albums[indexPath.row].available.count <= 5 {
				cell.availabilityLabel.text = nil
				cell.availabilityLabel.hidden = false
				
				for item in artist.albums[indexPath.row].available {
					if cell.availabilityLabel.text == nil {
						cell.availabilityLabel.text = item
					} else {
						cell.availabilityLabel.text = "\(cell.availabilityLabel.text!), \(item)"
					}
				}
				
			} else {
				cell.availabilityLabel.hidden = true
			}
		}
		
		return cell
		
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return artist?.albums.count ?? 0
	}

}
