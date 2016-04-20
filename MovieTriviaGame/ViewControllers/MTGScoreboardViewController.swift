//
//  MTGScoreboardViewController.swift
//  MovieTriviaGame
//
//  Created by Devinci on 4/19/16.
//  Copyright © 2016 JDRichardsTech. All rights reserved.
//

import UIKit

class MTGScoreboardViewController: UIViewController {

	var scoreboardTempLabel: UILabel!
	var totalPointsLabel:UILabel!
	
	
	
	
	
	override func loadView() {
		let frame = UIScreen.mainScreen().bounds
		let view = UIView(frame: frame)
		view.backgroundColor = UIColor(patternImage: UIImage(named: "backgound.png")!)
		
		
		
		// label that delivers the overview from themoviedb.org api
		self.scoreboardTempLabel = UILabel(frame:CGRect(x:10, y: 300, width: frame.size.width-20, height: 200))
		self.scoreboardTempLabel.center = CGPoint(x: 0.5 * frame.size.width, y: 300)
		self.scoreboardTempLabel.textAlignment = .Center
		self.scoreboardTempLabel.backgroundColor = UIColor.clearColor()
		self.scoreboardTempLabel?.text = "SCOREBOARD\rPLACEHOLDER"
		
		self.scoreboardTempLabel?.font = UIFont(name:"Menlo-Bold", size:35)
		self.scoreboardTempLabel?.textColor = UIColor.whiteColor()
		self.scoreboardTempLabel?.numberOfLines=0
		self.scoreboardTempLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
		//self.questionLabel?.adjustsFontSizeToFitWidth = true
		view.addSubview(scoreboardTempLabel)
		
	}
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
