//
//  MTGQuizViewController.swift
//  MovieTriviaGame
//
//  Created by Devinci on 4/18/16.
//  Copyright © 2016 JDRichardsTech. All rights reserved.
//

import UIKit
import Alamofire

class MTGQuizViewController: MTGViewController {

	var overviews = [AnyObject]()
	var titles = [AnyObject]()
	var questionLabel: UILabel!
	var wrongAnswerLabel: UILabel!
	var wrongChoice1 = [AnyObject]()
	var wrongChoice2 = [AnyObject]()
	var wrongChoice3 = [AnyObject]()
	var wrongQuestion1: AnyObject!
	var wrongQuestion2: AnyObject!
	var wrongQuestion3: AnyObject!
	
	var rightAnswerLabel: UILabel!
	var scoreLabel: UILabel!
	var choiceOneButton: UIButton!
	var choiceTwoButton: UIButton!
	var choiceThreeButton: UIButton!
	var choiceFourButton: UIButton!
	var nextQuestionButton: UIButton!
	var nextRightButton: Int!
	var nextRightMovie: Int!
	var rightAnswer: Int!

	
	var imageView: UIImageView!
	var rightQuestionPoster: Int!
	
	
	var movieArray = Array<MTGModel>()
 
	
	
	
	override func loadView() {
	
		super.loadView()
		self.edgesForExtendedLayout = .None
		self.title = "Movie Trivia Game"
		
		let frame = UIScreen.mainScreen().bounds
		let view = UIView(frame: frame)
		view.backgroundColor = UIColor(patternImage: UIImage(named: "backgound.png")!)
		
		
		//MARK: - Properties
		//MARK: - Labels
		// label that delivers the overview from themoviedb.org api
		self.questionLabel = UILabel(frame:CGRect(x:10, y: 120, width: frame.size.width-20, height: 200))
		self.questionLabel.center = CGPoint(x: 0.5 * frame.size.width, y: 120)
		self.questionLabel.textAlignment = .Center
		self.questionLabel.backgroundColor = UIColor.clearColor()
		self.questionLabel?.font = UIFont(name:"Menlo-Bold", size:13)
		self.questionLabel?.textColor = UIColor.whiteColor()
		self.questionLabel?.numberOfLines=0
		self.questionLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
		//self.questionLabel?.adjustsFontSizeToFitWidth = true
		view.addSubview(questionLabel)

		//wrong answer label **should start out hidden
		self.wrongAnswerLabel = UILabel(frame:CGRect(x:10, y: 150, width: frame.size.width-20, height: 200))
		self.wrongAnswerLabel.center = CGPoint(x: 0.5 * frame.size.width, y: 150)
		self.wrongAnswerLabel.backgroundColor = UIColor.clearColor()
		self.wrongAnswerLabel.textAlignment = .Center
		self.wrongAnswerLabel?.font = UIFont(name:"Menlo-Bold", size:25)
		self.wrongAnswerLabel?.textColor = UIColor.whiteColor()
		self.wrongAnswerLabel?.numberOfLines=0
		self.wrongAnswerLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
		//wrongAnswerLabel?.adjustsFontSizeToFitWidth = true
		view.addSubview(wrongAnswerLabel)

		//correct answer label should start out hidden
		self.rightAnswerLabel = UILabel(frame:CGRect(x:10, y: 150, width: frame.size.width-20, height: 50))
		self.rightAnswerLabel.center = CGPoint(x: 0.5 * frame.size.width, y: 150)
		self.rightAnswerLabel.backgroundColor = UIColor.clearColor()
		self.rightAnswerLabel.textAlignment = .Center
		self.rightAnswerLabel?.font = UIFont(name:"Menlo-Bold", size:25)
		self.rightAnswerLabel?.textColor = UIColor.whiteColor()
		self.rightAnswerLabel?.numberOfLines=0
		self.wrongAnswerLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
		//rightAnswerLabel?.adjustsFontSizeToFitWidth = true
		view.addSubview(rightAnswerLabel)
		
		
		
		//score label start out hidden
		self.scoreLabel = UILabel(frame:CGRect(x:10, y: 250, width: frame.size.width-20, height: 50))
		self.scoreLabel.center = CGPoint(x: 0.5 * frame.size.width, y: 250)
		self.scoreLabel.backgroundColor = UIColor.clearColor()
		self.scoreLabel.textAlignment = .Center
		self.scoreLabel?.font = UIFont(name:"Menlo-Bold", size:14)
		self.scoreLabel?.textColor = UIColor.whiteColor()
		self.scoreLabel?.numberOfLines=0
		self.scoreLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
		//scoreLabel?.adjustsFontSizeToFitWidth = true
		view.addSubview(scoreLabel)
		
		//MARK: - Buttons
		//choiceOneButton
		self.choiceOneButton = UIButton(type: .Custom)
		
		self.choiceOneButton.frame = CGRect(x: 0, y: 300, width: frame.size.width, height: 45)
		self.choiceOneButton.center = CGPoint(x: 0.5 * frame.size.width, y: 300)
		self.choiceOneButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
		
		self.choiceOneButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
		self.choiceOneButton.setTitleColor(UIColor.yellowColor(), forState: .Highlighted)
		self.choiceOneButton.titleLabel?.textAlignment = .Center
		self.choiceOneButton.titleLabel?.font = UIFont(name: "Menlo-Bold", size: 13)
		//self.choiceOneButton.layer.cornerRadius = 10
		//self.choiceOneButton.layer.borderWidth = 1
		self.choiceOneButton.titleLabel?.numberOfLines = 0;
		self.choiceOneButton.titleLabel?.adjustsFontSizeToFitWidth = true
		//self.choiceOneButton.layer.borderColor = UIColor.lightGrayColor().CGColor
		
		
		self.choiceOneButton.addTarget(self, action: #selector(self.choiceOneButtonAction(_:)), forControlEvents: .TouchUpInside)
		
		view.addSubview(choiceOneButton)
		
		//choiceTwoButton
		self.choiceTwoButton = UIButton(type: .Custom)
		
		self.choiceTwoButton.frame = CGRect(x: 0, y: 360, width: frame.size.width, height: 45)
		self.choiceTwoButton.center = CGPoint(x: 0.5 * frame.size.width, y: 360)
		self.choiceTwoButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
		//self.choiceTwoButton.setTitle("Choice3", forState: .Normal)
		self.choiceTwoButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
		self.choiceTwoButton.setTitleColor(UIColor.yellowColor(), forState: .Highlighted)
		self.choiceTwoButton.titleLabel?.textAlignment = .Center
		self.choiceTwoButton.titleLabel?.font = UIFont(name: "Menlo-Bold", size: 14)
		//self.choiceTwoButton.layer.cornerRadius = 10
		//self.choiceTwoButton.layer.borderWidth = 1
		self.choiceTwoButton.titleLabel?.numberOfLines = 0;
		self.choiceTwoButton.titleLabel?.adjustsFontSizeToFitWidth = true
		//self.choiceTwoButton.layer.borderColor = UIColor.lightGrayColor().CGColor
		
		
		
		self.choiceTwoButton.addTarget(self, action: #selector(self.choiceTwoButtonAction(_:)), forControlEvents: .TouchUpInside)
		
		view.addSubview(choiceTwoButton)
		
		
		
		//choiceThreeButton
		self.choiceThreeButton = UIButton(type: .Custom)
		
		self.choiceThreeButton.frame = CGRect(x: 0, y: 420, width: frame.size.width, height: 45)
		self.choiceThreeButton.center = CGPoint(x: 0.5 * frame.size.width, y: 420)
		self.choiceThreeButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
		//self.choiceThreeButton.setTitle("Choice4", forState: .Normal)
		self.choiceThreeButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
		self.choiceThreeButton.setTitleColor(UIColor.yellowColor(), forState: .Highlighted)
		self.choiceThreeButton.titleLabel?.textAlignment = .Center
		self.choiceThreeButton.titleLabel?.font = UIFont(name: "Menlo-Bold", size: 13)

		//self.choiceThreeButton.layer.cornerRadius = 10
		//self.choiceThreeButton.layer.borderWidth = 1
		self.choiceThreeButton.titleLabel?.numberOfLines = 0;
		self.choiceThreeButton.titleLabel?.adjustsFontSizeToFitWidth = true
		//self.choiceThreeButton.layer.borderColor = UIColor.lightGrayColor().CGColor
		
		
		self.choiceThreeButton.addTarget(self, action: #selector(self.choiceThreeButtonAction(_:)), forControlEvents: .TouchUpInside)
		
		view.addSubview(choiceThreeButton)
		
		//choiceFourButton
		self.choiceFourButton = UIButton(type: .Custom)
		
		self.choiceFourButton.frame = CGRect(x: 0, y: 480, width: frame.size.width, height: 45)
		self.choiceFourButton.center = CGPoint(x: 0.5 * frame.size.width, y: 480)
		self.choiceFourButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
		self.choiceFourButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
		self.choiceFourButton.setTitleColor(UIColor.yellowColor(), forState: .Highlighted)
		self.choiceFourButton.titleLabel?.textAlignment = .Center
		self.choiceFourButton.titleLabel?.font = UIFont(name: "Menlo-Bold", size: 14)
		//self.choiceFourButton.layer.cornerRadius = 10
		//self.choiceFourButton.layer.borderWidth = 1
		self.choiceFourButton.titleLabel?.numberOfLines = 0;
		self.choiceFourButton.titleLabel?.adjustsFontSizeToFitWidth = true
		//self.choiceFourButton.layer.borderColor = UIColor.blackColor().CGColor
		
		
		self.choiceFourButton.addTarget(self, action: #selector(self.choiceFourButtonAction(_:)), forControlEvents: .TouchUpInside)
		
		view.addSubview(choiceFourButton)
		
		
		
		
		//next question button starts hidden
		self.nextQuestionButton = UIButton(type: .Custom)
		
		self.nextQuestionButton.frame = CGRect(x: 0, y: 450, width: frame.size.width, height: 45)
		self.nextQuestionButton.center = CGPoint(x: 0.5 * frame.size.width, y: 450)
		self.nextQuestionButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
		self.nextQuestionButton.setTitle("Next Question", forState: .Normal)
		self.nextQuestionButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
		self.nextQuestionButton.titleLabel?.textAlignment = .Center
		self.nextQuestionButton.titleLabel?.font = UIFont(name: "Menlo-Bold", size: 14)
		//self.nextQuestionButton.layer.cornerRadius = 10
		//self.nextQuestionButton.layer.borderWidth = 1
		self.nextQuestionButton.titleLabel?.numberOfLines = 0;
		self.nextQuestionButton.titleLabel?.adjustsFontSizeToFitWidth = true
		//self.nextQuestionButton.layer.borderColor = UIColor.lightGrayColor().CGColor
		
		
		self.nextQuestionButton.addTarget(self, action: #selector(self.nextQuestionButtonAction(_:)), forControlEvents: .TouchUpInside)
		
		view.addSubview(nextQuestionButton)
		
		
	
		

		
		//hide answer screens
		
		self.hideRightAnswerScreen()
		self.hideWrongAnswerScreen()
		self.scoreLabel.hidden = true
		self.nextQuestionButton.hidden = true
		
		
		
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
						//print(movieInfo["overview"])
						self.movieArray.append(result)
						//print("MovieArray: \(self.movieArray)")
						
						self.titles.append(movieInfo["title"]!)
						self.overviews.append(movieInfo["overview"]!)
						//print("Overview \(self.overviews.count)")
						
						print ("Title \(self.titles.count)")
					}
					
					
					self.pickCorrectButton()
					self.questionChoice()
					
				}
				
				
				
			}
		}
		

	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	//MARK: - My Functions
	
	
	
	//this random chooses a number between 0 and 4 for the movieArray index
	func randomMovie()-> Int {
		
		//let randomIndex = Int(arc4random_uniform(UInt32(5)))
		let movieChoiceProgression = [1,2,3,4,5,6,7,8,9,10,11]
		let nextRightMovie = movieChoiceProgression[mainInstance.numberQuestionsAskedCount]
		return(nextRightMovie)
	}
	
	
	
	

	
	
	
	
	
	//this random chooses the button that holds the correct answer
	func pickCorrectButton(){
		
		 //self.questionNum = Int(arc4random_uniform(UInt32(4)))
		//print("Questionnum: \(questionNum)")
		let rightButtonProgression = [0,2,1,3,2,0,3,3,1,1,2]
		self.nextRightButton = rightButtonProgression[mainInstance.numberQuestionsAskedCount]
		//print(self.numberQuestionsAskedCount)
	}
	

	
	func questionChoice(){
	
		
		let rightQuestion  = self.randomMovie()
		for i in 0..<6 {
			wrongChoice1.append(self.titles[i])
			wrongChoice2.append(self.titles[i+6])
			wrongChoice3.append(self.titles[i+13])
		}
		for i in 0..<6 {
			wrongChoice1.append(self.titles[i+13])
			wrongChoice2.append(self.titles[i])
			wrongChoice3.append(self.titles[i+6])
		}
		self.wrongQuestion1 = wrongChoice1[mainInstance.numberQuestionsAskedCount]
		self.wrongQuestion2 = wrongChoice2[mainInstance.numberQuestionsAskedCount]
		self.wrongQuestion3 = wrongChoice3[mainInstance.numberQuestionsAskedCount]
		self.rightQuestionPoster = rightQuestion
		
		if(self.wrongQuestion1 === titles[rightQuestion]){
			self.wrongQuestion1 = self.titles[19]
		}
		if(self.wrongQuestion2 === titles[rightQuestion]){
			self.wrongQuestion1 = self.titles[18]
		}
		if(self.wrongQuestion3 === titles[rightQuestion]){
			self.wrongQuestion1 = self.titles[19]
		}
		print(wrongChoice1)
		print(wrongChoice2)
		print(wrongChoice3)
		
		
		
		
		
		self.rightAnswerLabel?.text = "YOU GOT IT!!!"
		
		switch(self.nextRightButton){
			
		case 0:
			self.questionLabel?.text = "\(overviews[rightQuestion])"
			self.choiceOneButton.setTitle("\(titles[rightQuestion])", forState: .Normal)
			self.choiceTwoButton.setTitle("\(self.wrongQuestion1)", forState: .Normal)
			self.choiceThreeButton.setTitle("\(self.wrongQuestion2)", forState: .Normal)
			self.choiceFourButton.setTitle("\(self.wrongQuestion3)", forState: .Normal)
			self.wrongAnswerLabel?.text = "WRONG!!!\r\rThe Answer is: \r \(titles[rightQuestion])"
			self.rightAnswerLabel?.text = "YOU GOT IT!!!"
			self.rightAnswer = 1
			
		case 1:
			
			self.questionLabel?.text = "\(overviews[rightQuestion])"
			self.choiceOneButton.setTitle("\(self.wrongQuestion1)", forState: .Normal)
			self.choiceTwoButton.setTitle("\(titles[rightQuestion])", forState: .Normal)
			self.choiceThreeButton.setTitle("\(self.wrongQuestion2)", forState: .Normal)
			self.choiceFourButton.setTitle("\(self.wrongQuestion3)", forState: .Normal)
			
			self.wrongAnswerLabel?.text = "WRONG!!!\r\rThe Answer is:\r\(self.movieArray[rightQuestion].title)"
			
			self.rightAnswer = 2
			
		case 2:
			
			self.questionLabel?.text = "\(overviews[rightQuestion])"
			self.choiceOneButton.setTitle("\(self.wrongQuestion1)", forState: .Normal)
			self.choiceTwoButton.setTitle("\(self.wrongQuestion2)", forState: .Normal)
			self.choiceThreeButton.setTitle("\(titles[rightQuestion])", forState: .Normal)
			self.choiceFourButton.setTitle("\(self.wrongQuestion3)", forState: .Normal)
			
			self.wrongAnswerLabel?.text = "WRONG!!!\r\rThe Answer is:\r\(titles[rightQuestion])"
			
			self.rightAnswer = 3
		
		case 3:
			
			self.questionLabel?.text = "\(overviews[rightQuestion])"
			self.choiceOneButton.setTitle("\(self.wrongQuestion1)", forState: .Normal)
			self.choiceTwoButton.setTitle("\(self.wrongQuestion2)", forState: .Normal)
			self.choiceThreeButton.setTitle("\(self.wrongQuestion3)", forState: .Normal)
			self.choiceFourButton.setTitle("\(titles[rightQuestion])", forState: .Normal)
			
			self.wrongAnswerLabel?.text = "WRONG!!!\r\rThe Answer is:\r\(titles[rightQuestion])"
			self.rightAnswer = 4
			
		default:
			self.questionLabel?.text = "\(overviews[rightQuestion])"
			self.choiceOneButton.setTitle("\(self.wrongQuestion1)", forState: .Normal)
			self.choiceTwoButton.setTitle("\(self.wrongQuestion2)", forState: .Normal)
			self.choiceThreeButton.setTitle("\(self.wrongQuestion3)", forState: .Normal)
			self.choiceFourButton.setTitle("\(titles[rightQuestion])", forState: .Normal)
			
			self.wrongAnswerLabel?.text = "WRONG!!! \r\rThe Answer is:\r\(titles[rightQuestion])"
			self.rightAnswer = 3
	
			}
	
	}
	
	
	
	//MARK: - Answer Screens
	func showWrongAnswerScreen(){
		self.pickCorrectButton()
		//print("Wrong answers \(self.sumWrongAnswers)")
		self.scoreLabel?.text = "Right Answers: \(mainInstance.sumRightAnswers) \rWrong Answers: \(mainInstance.sumWrongAnswers)\rTotal Points: \(mainInstance.totalPoints)"
		self.wrongAnswerLabel.hidden = false
		self.scoreLabel.hidden = false
		self.nextQuestionButton.hidden = false
	}
	
	func showRightAnswerScreen(){
		self.pickCorrectButton()
		self.scoreLabel?.text = "Right Answers: \(mainInstance.sumRightAnswers) \rWrong Answers: \(mainInstance.sumWrongAnswers)\rTotal Points: \(mainInstance.totalPoints)"
		self.rightAnswerLabel.hidden = false
		self.scoreLabel.hidden = false
		self.nextQuestionButton.hidden = false
	
	}
	
	func hideWrongAnswerScreen(){
		self.wrongAnswerLabel.hidden = true
		self.scoreLabel.hidden = true
		self.nextQuestionButton.hidden = true
	}
	
	func hideRightAnswerScreen(){
		self.rightAnswerLabel.hidden = true
		self.scoreLabel.hidden = true
		self.nextQuestionButton.hidden = true
	}
	
	func addToRightAnswer(){
		mainInstance.sumRightAnswers += 10
		mainInstance.totalPoints = mainInstance.sumRightAnswers + mainInstance.sumWrongAnswers
		//self.MScoreVc.totalPoints = self.totalPoints
	}
	
	func addToWrongAnswer(){
		mainInstance.sumWrongAnswers -= 5
		mainInstance.totalPoints = mainInstance.sumRightAnswers + mainInstance.sumWrongAnswers
		//self.MScoreVc.totalPoints = self.totalPoints
		
	
	}
	
	

	
	
	//MARK: - Button Functions
	
	
	func hideButtons(){
		self.questionLabel.hidden = true
		self.choiceOneButton.hidden = true
		self.choiceTwoButton.hidden = true
		self.choiceThreeButton.hidden = true
		self.choiceFourButton.hidden = true
	}
	
	func showButtons(){
		self.questionLabel.hidden = false
		self.choiceOneButton.hidden = false
		self.choiceTwoButton.hidden = false
		self.choiceThreeButton.hidden = false
		self.choiceFourButton.hidden = false
		self.wrongAnswerLabel.hidden = true
	}
	
	
	func choiceOneButtonAction(btn:UIButton){
		mainInstance.numberQuestionsAskedCount += 1
		if(self.rightAnswer == 1){
			self.addToRightAnswer()
			self.hideButtons()
			self.showRightAnswerScreen()
			//print("right")
		}
		else{
			self.addToWrongAnswer()
			self.hideButtons()
			self.showWrongAnswerScreen()
			//print("wrong")
			
		}
	}
	func choiceTwoButtonAction(btn:UIButton){
		mainInstance.numberQuestionsAskedCount += 1
		
		if(self.rightAnswer == 2){
			self.addToRightAnswer()
			self.hideButtons()
			self.showRightAnswerScreen()
			
			print("right")
		}
		else{
			self.addToWrongAnswer()
			self.hideButtons()
			self.showWrongAnswerScreen()
			print("wrong")
		}
	}
	func choiceThreeButtonAction(btn:UIButton){
		mainInstance.numberQuestionsAskedCount += 1
		if(self.rightAnswer == 3){
			self.addToRightAnswer()
			self.hideButtons()
			self.showRightAnswerScreen()
			print("right")
		}
		else{
			self.addToWrongAnswer()
			self.showWrongAnswerScreen()
			self.hideButtons()
			print("wrong")
		}
	}
	func choiceFourButtonAction(btn:UIButton){
		mainInstance.numberQuestionsAskedCount += 1
		if(self.rightAnswer == 4){
			self.addToRightAnswer()
			self.hideButtons()
			self.showRightAnswerScreen()
			print("right")
		}
		else{
			self.addToWrongAnswer()
			self.hideButtons()
			self.showWrongAnswerScreen()
			print("wrong")
			
		}
	}
	
	func nextQuestionButtonAction(btn:UIButton){
		//self.numberQuestionsAskedCount += 1
		//self.totalPonits = self.sumRightAnswers + self.sumWrongAnswers
		if(mainInstance.numberQuestionsAskedCount < 10){
		self.hideRightAnswerScreen()
		self.hideWrongAnswerScreen()
		
		self.questionChoice()
		self.showButtons()
			
		//print ("Total points: \(self.totalPonits)")
		}
		else{
			
			self.navigationController?.pushViewController(MTGScoreboardViewController(), animated: true)
		}
		
		
	
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

