//
//  MTGModel.swift
//  MovieTriviaGame
//
//  Created by Devinci on 4/18/16.
//  Copyright © 2016 JDRichardsTech. All rights reserved.
//

import UIKit

class MTGModel: NSObject {
	
	var overview: String!
	var title: String!
	var id: Double!
	var count: Int!
	var randomIndex:Int!
	var posterPath: String!
	

	
	
	
	
	func populate(info: Dictionary<String,AnyObject>){
		
		if let posterPath = info["poster_path"] as? String{
			self.posterPath = posterPath
		}
		
		if let overview = info["overview"] as? String{
			self.overview = overview
			//print ("Model Array: \(self.overview)")
		}
		if let title = info["title"] as? String{
			self.title = title
		}
		if let id = info["id"] as? Double{
			self.id = id
					}
		
		
		
	}
}
