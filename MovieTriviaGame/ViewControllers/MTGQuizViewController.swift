//
//  MTGQuizViewController.swift
//  MovieTriviaGame
//
//  Created by Devinci on 4/18/16.
//  Copyright © 2016 JDRichardsTech. All rights reserved.
//

import UIKit
import Alamofire

class MTGQuizViewController: UIViewController {

	var questionLabel: UILabel!
	var choiceOneButton: UIButton!
	var choiceTwoButton: UIButton!
	var choiceThreeButton: UIButton!
	var choiceFourButton: UIButton!
	var movieArray = Array<MTGModel>()
//var randomItem: String!
 
	
	
	
	override func loadView() {
	
		super.loadView()
		self.edgesForExtendedLayout = .None
		
		
		let frame = UIScreen.mainScreen().bounds
		let view = UIView(frame: frame)
		view.backgroundColor = UIColor.cyanColor()
		
		
		
		
		
		self.questionLabel = UILabel(frame:CGRect(x:10, y: 120, width: frame.size.width-20, height: 200))
		self.questionLabel.center = CGPoint(x: 0.5 * frame.size.width, y: 120)
		self.questionLabel.backgroundColor = UIColor.clearColor()
		//self.questionLabel?.text = "hello"
		
		self.questionLabel?.font = UIFont(name:"Arial", size:13)
		self.questionLabel?.textColor = UIColor.blackColor()
		self.questionLabel?.numberOfLines=0
		self.questionLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
		//self.questionLabel?.adjustsFontSizeToFitWidth = true
		view.addSubview(questionLabel)
//
		

		
		
		
		
		//choiceOneButton
		self.choiceOneButton = UIButton(type: .Custom)
		
		self.choiceOneButton.frame = CGRect(x: 0, y: 270, width: frame.size.width-20, height: 45)
		self.choiceOneButton.center = CGPoint(x: 0.5 * frame.size.width, y: 270)
		self.choiceOneButton.backgroundColor = UIColor.blueColor()
		//self.choiceOneButton.setTitle("Choice1", forState: .Normal)
		self.choiceOneButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
		self.choiceOneButton.titleLabel?.textAlignment = .Center
		self.choiceOneButton.titleLabel?.font = UIFont(name: "Arial", size: 14)
		self.choiceOneButton.layer.cornerRadius = 10
		self.choiceOneButton.layer.borderWidth = 1
		self.choiceOneButton.titleLabel?.numberOfLines = 0;
		self.choiceOneButton.titleLabel?.adjustsFontSizeToFitWidth = true
		self.choiceOneButton.layer.borderColor = UIColor.lightGrayColor().CGColor
		
		
		//self.realEstateButton.addTarget(self, action: #selector(NYTFeedViewController.btnNextActionRealEstate(_:)), forControlEvents: .TouchUpInside)
		
		view.addSubview(choiceOneButton)
		
		//choiceTwoButton
		self.choiceTwoButton = UIButton(type: .Custom)
		
		self.choiceTwoButton.frame = CGRect(x: 0, y: 325, width: frame.size.width-20, height: 45)
		self.choiceTwoButton.center = CGPoint(x: 0.5 * frame.size.width, y: 325)
		self.choiceTwoButton.backgroundColor = UIColor.blueColor()
		//self.choiceTwoButton.setTitle("Choice3", forState: .Normal)
		self.choiceTwoButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
		self.choiceTwoButton.titleLabel?.textAlignment = .Center
		self.choiceTwoButton.titleLabel?.font = UIFont(name: "Arial", size: 14)
		self.choiceTwoButton.layer.cornerRadius = 10
		self.choiceTwoButton.layer.borderWidth = 1
		self.choiceTwoButton.titleLabel?.numberOfLines = 0;
		self.choiceTwoButton.titleLabel?.adjustsFontSizeToFitWidth = true
		self.choiceTwoButton.layer.borderColor = UIColor.lightGrayColor().CGColor
		
		
		
		//self.foodButton.addTarget(self, action: #selector(NYTFeedViewController.btnNextActionFood(_:)), forControlEvents: .TouchUpInside)
		
		view.addSubview(choiceTwoButton)
		
		
		
		//choiceThreeButton
		self.choiceThreeButton = UIButton(type: .Custom)
		
		self.choiceThreeButton.frame = CGRect(x: 0, y: 390, width: frame.size.width-20, height: 45)
		self.choiceThreeButton.center = CGPoint(x: 0.5 * frame.size.width, y: 390)
		self.choiceThreeButton.backgroundColor = UIColor.blueColor()
		//self.choiceThreeButton.setTitle("Choice4", forState: .Normal)
		self.choiceThreeButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
		self.choiceThreeButton.titleLabel?.textAlignment = .Center
		self.choiceThreeButton.titleLabel?.font = UIFont(name: "Arial", size: 14)

		self.choiceThreeButton.layer.cornerRadius = 10
		self.choiceThreeButton.layer.borderWidth = 1
		self.choiceThreeButton.titleLabel?.numberOfLines = 0;
		self.choiceThreeButton.titleLabel?.adjustsFontSizeToFitWidth = true
		self.choiceThreeButton.layer.borderColor = UIColor.lightGrayColor().CGColor
		
		
		//self.businessButton.addTarget(self, action: #selector(NYTFeedViewController.btnNextActionBusiness(_:)), forControlEvents: .TouchUpInside)
		
		view.addSubview(choiceThreeButton)
		
		//choiceFourButton
		self.choiceFourButton = UIButton(type: .Custom)
		
		self.choiceFourButton.frame = CGRect(x: 0, y: 455, width: frame.size.width-20, height: 45)
		self.choiceFourButton.center = CGPoint(x: 0.5 * frame.size.width, y: 455)
		self.choiceFourButton.backgroundColor = UIColor.blueColor()
		//self.choiceFourButton.setTitle("Arts", forState: .Normal)
		self.choiceFourButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
		self.choiceFourButton.titleLabel?.textAlignment = .Center
		self.choiceFourButton.titleLabel?.font = UIFont(name: "Arial", size: 14)
		self.choiceFourButton.layer.cornerRadius = 10
		self.choiceFourButton.layer.borderWidth = 1
		self.choiceFourButton.titleLabel?.numberOfLines = 0;
		self.choiceFourButton.titleLabel?.adjustsFontSizeToFitWidth = true
		self.choiceFourButton.layer.borderColor = UIColor.lightGrayColor().CGColor
		
		
		//self.artsButton.addTarget(self, action: #selector(NYTFeedViewController.btnNextActionArts(_:)), forControlEvents: .TouchUpInside)
		
		view.addSubview(choiceFourButton)
		
		
		

		
		
		
		
		
		self.view = view
	}
	
	
	override func viewDidLoad() {
        super.viewDidLoad()

		let url = "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=98b525225a2fe71d855108eca4fdf12d"
		
		
		Alamofire.request(.GET, url, parameters: nil).responseJSON { response in
			if let JSON = response.result.value as? Dictionary<String, AnyObject> {
				//print("\(JSON)")
				
				if let results = JSON["results"] as? Array<Dictionary<String,AnyObject>>{
					
					//print("\(results)")
					for movieInfo in results{
						//print("OK: \(self.movieArray)")
						//print("\(results)")
						let result = MTGModel()
						result.populate(movieInfo)
						self.movieArray.append(result)
					}
					//self.reloadInputViews()
					//self.questionLabel?.text = "\(self.movieArray[1].overview)"
					self.questionFunction()
					self.randomMovie()
					
					
					
				//	let devices = self.movieArray.title
					// Generate a random index
					
				}
				
				
				
			}
		}
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	
	func randomMovie()-> Int {
		
		let randomIndex = Int(arc4random_uniform(UInt32(self.movieArray.count)))
		
		return(randomIndex)
	
	
	}
	
	func questionFunction(){
	
	self.questionLabel?.text = "\(self.movieArray[0].overview)"
	self.choiceOneButton.setTitle("\(self.movieArray[randomMovie()].title)", forState: .Normal)
	self.choiceTwoButton.setTitle("\(self.movieArray[randomMovie()].title)", forState: .Normal)
	self.choiceThreeButton.setTitle("\(self.movieArray[randomMovie()].title)", forState: .Normal)
	self.choiceFourButton.setTitle("\(self.movieArray[randomMovie()].title)", forState: .Normal)
	
	}
	
	
	

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

