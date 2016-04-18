//
//  ViewController.swift
//  MovieTriviaGame
//
//  Created by Devinci on 4/18/16.
//  Copyright © 2016 JDRichardsTech. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

	
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let url = "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=98b525225a2fe71d855108eca4fdf12d"
		
		
		Alamofire.request(.GET, url, parameters: nil).responseJSON { response in
			if let JSON = response.result.value as? Dictionary<String, AnyObject> {
		print("\(JSON)")
			}
		}
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

