//
//  MTGScoreboardViewController.swift
//  MovieTriviaGame
//
//  Created by Devinci on 4/19/16.
//  Copyright © 2016 JDRichardsTech. All rights reserved.
//

import UIKit

class MTGScoreboardViewController: MTGViewController {

	var scoreboardTempLabel: UILabel!
	var totalPointsLabel:UILabel!
	var scoreComment: UILabel!
	var tryAgainButton:UIButton!
	
	
	
	
	
	
	override func loadView() {
		let frame = UIScreen.mainScreen().bounds
		let view = UIView(frame: frame)
		view.backgroundColor = UIColor(patternImage: UIImage(named: "backgound.png")!)
		//let MQuizVc = MTGQuizViewController()
		
		
	
		
		// label that delivers the overview from themoviedb.org api
		self.scoreboardTempLabel = UILabel(frame:CGRect(x:10, y: 100, width: frame.size.width-20, height: 50))
		self.scoreboardTempLabel.center = CGPoint(x: 0.5 * frame.size.width, y: 100)
		self.scoreboardTempLabel.textAlignment = .Center
		self.scoreboardTempLabel.backgroundColor = UIColor.clearColor()
		self.scoreboardTempLabel?.text = "GAME OVER"
		
		self.scoreboardTempLabel?.font = UIFont(name:"Menlo-Bold", size:35)
		self.scoreboardTempLabel?.textColor = UIColor.whiteColor()
		self.scoreboardTempLabel?.numberOfLines=0
		self.scoreboardTempLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
		//self.questionLabel?.adjustsFontSizeToFitWidth = true
		view.addSubview(scoreboardTempLabel)
		
		// label that delivers the overview from themoviedb.org api
		self.totalPointsLabel = UILabel(frame:CGRect(x:10, y: 150, width: frame.size.width-20, height: 50))
		self.totalPointsLabel.center = CGPoint(x: 0.5 * frame.size.width, y: 150)
		self.totalPointsLabel.textAlignment = .Center
		self.totalPointsLabel.backgroundColor = UIColor.clearColor()
		self.totalPointsLabel?.text = "FINAL SCORE: \(mainInstance.totalPoints)"
		
		self.totalPointsLabel?.font = UIFont(name:"Menlo-Bold", size:25)
		self.totalPointsLabel?.textColor = UIColor.whiteColor()
		self.totalPointsLabel?.numberOfLines=0
		self.totalPointsLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
		//totalPointsLabel?.adjustsFontSizeToFitWidth = true
		view.addSubview(totalPointsLabel)
		
		
		// label that delivers the overview from themoviedb.org api
		self.scoreComment = UILabel(frame:CGRect(x:10, y: 225, width: frame.size.width-20, height: 200))
		self.scoreComment.center = CGPoint(x: 0.5 * frame.size.width, y: 225)
		self.scoreComment.textAlignment = .Center
		self.scoreComment.backgroundColor = UIColor.clearColor()
		//self.scoreComment?.text = "FINAL SCORE: \(mainInstance.totalPoints)"
		
		self.scoreComment?.font = UIFont(name:"Menlo-Bold", size:25)
		self.scoreComment?.textColor = UIColor.whiteColor()
		self.scoreComment?.numberOfLines=0
		self.scoreComment?.lineBreakMode = NSLineBreakMode.ByWordWrapping
		//totalPointsLabel?.adjustsFontSizeToFitWidth = true
		view.addSubview(scoreComment)
		
		
		
		//choiceOneButton
		self.tryAgainButton = UIButton(type: .Custom)
		
		self.tryAgainButton.frame = CGRect(x: 0, y: 420, width: frame.size.width, height: 45)
		self.tryAgainButton.center = CGPoint(x: 0.5 * frame.size.width, y: 420)
		self.tryAgainButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
		self.tryAgainButton
			.setTitle("Play Again?", forState: .Normal)
		self.tryAgainButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
		self.tryAgainButton.setTitleColor(UIColor.yellowColor(), forState: .Highlighted)
		self.tryAgainButton.titleLabel?.textAlignment = .Center
		self.tryAgainButton.titleLabel?.font = UIFont(name: "Menlo-Bold", size: 13)
		//self.choiceOneButton.layer.cornerRadius = 10
		//self.tryAgainButton.layer.borderWidth = 1
		self.tryAgainButton.titleLabel?.numberOfLines = 0;
		self.tryAgainButton.titleLabel?.adjustsFontSizeToFitWidth = true
		//self.tryAgainButton.layer.borderColor = UIColor.lightGrayColor().CGColor
		
		
		self.tryAgainButton.addTarget(self, action: #selector(self.newGameAction(_:)), forControlEvents: .TouchUpInside)
		
		
//		self.choiceTwoButton.addTarget(self, action: #selector(self.choiceTwoButtonAction(_:)), forControlEvents: .TouchUpInside)
		
		
		view.addSubview(tryAgainButton)
		
		self.view = view
	}
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.comment()
		
		if (mainInstance.totalPoints == 100){
			tryAgainButton.hidden = true
		}
		else{
			tryAgainButton.hidden = false
		}
		
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	
	 // MARK: - My Functions
	
	func comment(){
		if(mainInstance.totalPoints < 0){
			self.scoreComment?.text = "You REALLY SUCK!"
		}
		else if(mainInstance.totalPoints>0 && mainInstance.totalPoints<50){
			self.scoreComment?.text = "Better luck next time!"
		}
		else if(mainInstance.totalPoints>50 && mainInstance.totalPoints<100){
			self.scoreComment?.text = "Nice job!"
		}
		else{
			
			self.scoreComment?.text = "PERFECT SCORE!\r\rROCKSTAR!!"
		}
		
	
	}
	
	
	func newGameAction(btn:UIButton){
		mainInstance.totalPoints=0
		mainInstance.sumRightAnswers=0
		mainInstance.sumWrongAnswers=0
		mainInstance.numberQuestionsAskedCount=0
		self.navigationController?.pushViewController(MTGQuizViewController(), animated: true)
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
