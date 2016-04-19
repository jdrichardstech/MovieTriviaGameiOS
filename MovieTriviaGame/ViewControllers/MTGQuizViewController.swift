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
	var wrongAnswerLabel: UILabel!
	var rightAnswerLabel: UILabel!
	var choiceOneButton: UIButton!
	var choiceTwoButton: UIButton!
	var choiceThreeButton: UIButton!
	var choiceFourButton: UIButton!
	var questionNum: Int!
	var rightAnswer: Int!
	var sumRightAnswers: Int! = 0
	var sumWrongAnswers: Int! = 0
	var movieArray = Array<MTGModel>()
 
	
	
	
	override func loadView() {
	
		super.loadView()
		self.edgesForExtendedLayout = .None
		
		
		let frame = UIScreen.mainScreen().bounds
		let view = UIView(frame: frame)
		view.backgroundColor = UIColor(patternImage: UIImage(named: "backgound.png")!)
		
		
		//MARK: - Properties
		
		// label that delivers the overview from themoviedb.org api
		self.questionLabel = UILabel(frame:CGRect(x:10, y: 100, width: frame.size.width-20, height: 200))
		self.questionLabel.center = CGPoint(x: 0.5 * frame.size.width, y: 100)
		self.questionLabel.backgroundColor = UIColor.clearColor()
		//self.questionLabel?.text = "hello"
		
		self.questionLabel?.font = UIFont(name:"Menlo-Bold", size:13)
		self.questionLabel?.textColor = UIColor.whiteColor()
		self.questionLabel?.numberOfLines=0
		self.questionLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
		//self.questionLabel?.adjustsFontSizeToFitWidth = true
		view.addSubview(questionLabel)

		//label for wrong answers **should start out hidden
		self.wrongAnswerLabel = UILabel(frame:CGRect(x:10, y: 300, width: frame.size.width-20, height: 200))
		self.wrongAnswerLabel.center = CGPoint(x: 0.5 * frame.size.width, y: 100)
		self.wrongAnswerLabel.backgroundColor = UIColor.clearColor()
		//wrongAnswerLabel?.text = "hello"
		
		self.wrongAnswerLabel?.font = UIFont(name:"Menlo-Bold", size:25)
		self.wrongAnswerLabel?.textColor = UIColor.whiteColor()
		self.wrongAnswerLabel?.numberOfLines=0
		self.wrongAnswerLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
		//wrongAnswerLabel?.adjustsFontSizeToFitWidth = true
		view.addSubview(wrongAnswerLabel)

		//labe for right answers should start out hidden
		self.rightAnswerLabel = UILabel(frame:CGRect(x:10, y: 300, width: frame.size.width-20, height: 200))
		self.rightAnswerLabel.center = CGPoint(x: 0.5 * frame.size.width, y: 100)
		self.rightAnswerLabel.backgroundColor = UIColor.clearColor()
		//self.rightAnswerLabel?.text = "hello"
		
		self.rightAnswerLabel?.font = UIFont(name:"Menlo-Bold", size:25)
		self.rightAnswerLabel?.textColor = UIColor.whiteColor()
		self.rightAnswerLabel?.numberOfLines=0
		self.wrongAnswerLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
		//rightAnswerLabel?.adjustsFontSizeToFitWidth = true
		view.addSubview(rightAnswerLabel)
		
		
		//choiceOneButton
		self.choiceOneButton = UIButton(type: .Custom)
		
		self.choiceOneButton.frame = CGRect(x: 0, y: 270, width: frame.size.width-20, height: 45)
		self.choiceOneButton.center = CGPoint(x: 0.5 * frame.size.width, y: 270)
		self.choiceOneButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
		self.choiceOneButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
		self.choiceOneButton.titleLabel?.textAlignment = .Center
		self.choiceOneButton.titleLabel?.font = UIFont(name: "Menlo-Bold", size: 14)
		self.choiceOneButton.layer.cornerRadius = 10
		self.choiceOneButton.layer.borderWidth = 1
		self.choiceOneButton.titleLabel?.numberOfLines = 0;
		self.choiceOneButton.titleLabel?.adjustsFontSizeToFitWidth = true
		self.choiceOneButton.layer.borderColor = UIColor.lightGrayColor().CGColor
		
		
		self.choiceOneButton.addTarget(self, action: #selector(self.choiceOneButtonAction(_:)), forControlEvents: .TouchUpInside)
		
		view.addSubview(choiceOneButton)
		
		//choiceTwoButton
		self.choiceTwoButton = UIButton(type: .Custom)
		
		self.choiceTwoButton.frame = CGRect(x: 0, y: 325, width: frame.size.width-20, height: 45)
		self.choiceTwoButton.center = CGPoint(x: 0.5 * frame.size.width, y: 325)
		self.choiceTwoButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
		//self.choiceTwoButton.setTitle("Choice3", forState: .Normal)
		self.choiceTwoButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
		self.choiceTwoButton.titleLabel?.textAlignment = .Center
		self.choiceTwoButton.titleLabel?.font = UIFont(name: "Menlo-Bold", size: 14)
		self.choiceTwoButton.layer.cornerRadius = 10
		self.choiceTwoButton.layer.borderWidth = 1
		self.choiceTwoButton.titleLabel?.numberOfLines = 0;
		self.choiceTwoButton.titleLabel?.adjustsFontSizeToFitWidth = true
		self.choiceTwoButton.layer.borderColor = UIColor.lightGrayColor().CGColor
		
		
		
		self.choiceTwoButton.addTarget(self, action: #selector(self.choiceTwoButtonAction(_:)), forControlEvents: .TouchUpInside)
		
		view.addSubview(choiceTwoButton)
		
		
		
		//choiceThreeButton
		self.choiceThreeButton = UIButton(type: .Custom)
		
		self.choiceThreeButton.frame = CGRect(x: 0, y: 390, width: frame.size.width-20, height: 45)
		self.choiceThreeButton.center = CGPoint(x: 0.5 * frame.size.width, y: 390)
		self.choiceThreeButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
		//self.choiceThreeButton.setTitle("Choice4", forState: .Normal)
		self.choiceThreeButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
		self.choiceThreeButton.titleLabel?.textAlignment = .Center
		self.choiceThreeButton.titleLabel?.font = UIFont(name: "Menlo-Bold", size: 14)

		self.choiceThreeButton.layer.cornerRadius = 10
		self.choiceThreeButton.layer.borderWidth = 1
		self.choiceThreeButton.titleLabel?.numberOfLines = 0;
		self.choiceThreeButton.titleLabel?.adjustsFontSizeToFitWidth = true
		self.choiceThreeButton.layer.borderColor = UIColor.lightGrayColor().CGColor
		
		
		self.choiceThreeButton.addTarget(self, action: #selector(self.choiceThreeButtonAction(_:)), forControlEvents: .TouchUpInside)
		
		view.addSubview(choiceThreeButton)
		
		//choiceFourButton
		self.choiceFourButton = UIButton(type: .Custom)
		
		self.choiceFourButton.frame = CGRect(x: 0, y: 455, width: frame.size.width-20, height: 45)
		self.choiceFourButton.center = CGPoint(x: 0.5 * frame.size.width, y: 455)
		self.choiceFourButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
		//self.choiceFourButton.setTitle("Arts", forState: .Normal)
		self.choiceFourButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
		self.choiceFourButton.titleLabel?.textAlignment = .Center
		self.choiceFourButton.titleLabel?.font = UIFont(name: "Menlo-Bold", size: 14)
		self.choiceFourButton.layer.cornerRadius = 10
		self.choiceFourButton.layer.borderWidth = 1
		self.choiceFourButton.titleLabel?.numberOfLines = 0;
		self.choiceFourButton.titleLabel?.adjustsFontSizeToFitWidth = true
		self.choiceFourButton.layer.borderColor = UIColor.lightGrayColor().CGColor
		
		
		self.choiceFourButton.addTarget(self, action: #selector(self.choiceFourButtonAction(_:)), forControlEvents: .TouchUpInside)
		
		view.addSubview(choiceFourButton)
		
		
		

		
		//hide answer screens
		self.hideRightAnswerScreen()
		self.hideWrongAnswerScreen()
		
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
				
					self.pickCorrectButton()
					self.questionChoice()
					
					print(self.questionNum)
					
					
				
					
				}
				
				
				
			}
		}
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	
	
	
//	func questionFunction(){
//	
//	self.questionLabel?.text = "\(self.movieArray[0].overview)"
//	self.choiceOneButton.setTitle("\(self.movieArray[randomMovie()].title)", forState: .Normal)
//	self.choiceTwoButton.setTitle("\(self.movieArray[randomMovie()].title)", forState: .Normal)
//	self.choiceThreeButton.setTitle("\(self.movieArray[randomMovie()].title)", forState: .Normal)
//	self.choiceFourButton.setTitle("\(self.movieArray[randomMovie()].title)", forState: .Normal)
//	
//	}
//	
	
//	func randomButton() -> String{
//		let arr = ["choiceOneButton","choiceTwoButton","choiceThreeButton","choiceFourButton"]
//		let randomIndex = Int(arc4random_uniform(UInt32(arr.count)))
//		print (arr[randomIndex])
//		return arr[randomIndex]
//	}
	
	
	
	//this random finds the movies from the api
	func randomMovie()-> Int {
		
		let randomIndex = Int(arc4random_uniform(UInt32(3)))
		
		return(randomIndex)
	
		
	}
	//this random chooses the button to make the correct answer
	func pickCorrectButton() ->Int{
		
		 self.questionNum = Int(arc4random_uniform(UInt32(4)))
		
		return(questionNum)
		
	}
	
	func questionChoice(){
		
		
		let rightQuestion  = self.randomMovie()
		let wrongQuestion1 = self.randomMovie()
		let wrongQuestion2 = self.randomMovie()
		let wrongQuestion3 = self.randomMovie()
		
		switch(self.questionNum){
			
		case 0:
			self.questionLabel?.text = "\(self.movieArray[rightQuestion].overview)"
			self.choiceOneButton.setTitle("\(self.movieArray[rightQuestion].title)", forState: .Normal)
			self.choiceTwoButton.setTitle("\(self.movieArray[wrongQuestion1].title)", forState: .Normal)
			self.choiceThreeButton.setTitle("\(self.movieArray[wrongQuestion2].title)", forState: .Normal)
			self.choiceFourButton.setTitle("\(self.movieArray[wrongQuestion3].title)", forState: .Normal)
			self.wrongAnswerLabel?.text = "WRONG!!! \r The Answer is: \r \(self.movieArray[rightQuestion].title) \r \(self.sumRightAnswers) Right Answers \r \(self.sumWrongAnswers) Wrong Answers"
			self.rightAnswerLabel?.text = "YOU GOT IT!!! \r \(self.sumRightAnswers) Right Answers \r \(self.sumWrongAnswers) Wrong Answers"
			self.rightAnswer = 1
			
		case 1:
			
			self.questionLabel?.text = "\(self.movieArray[rightQuestion].overview)"
			self.choiceOneButton.setTitle("\(self.movieArray[wrongQuestion1].title)", forState: .Normal)
			self.choiceTwoButton.setTitle("\(self.movieArray[rightQuestion].title)", forState: .Normal)
			self.choiceThreeButton.setTitle("\(self.movieArray[wrongQuestion2].title)", forState: .Normal)
			self.choiceFourButton.setTitle("\(self.movieArray[wrongQuestion3].title)", forState: .Normal)
			self.wrongAnswerLabel?.text = "WRONG!!! \r The Answer is: \r\r \(self.movieArray[rightQuestion].title) \r \(self.sumRightAnswers) Right Answers \r \(self.sumWrongAnswers) Wrong Answers )"
			self.rightAnswerLabel?.text = "YOU GOT IT!!! \r \(self.sumRightAnswers) Right Answers \r \(self.sumWrongAnswers) Wrong Answers"
			self.rightAnswer = 2
			
		case 2:
			
			self.questionLabel?.text = "\(self.movieArray[rightQuestion].overview)"
			self.choiceOneButton.setTitle("\(self.movieArray[wrongQuestion1].title)", forState: .Normal)
			self.choiceTwoButton.setTitle("\(self.movieArray[wrongQuestion2].title)", forState: .Normal)
			self.choiceThreeButton.setTitle("\(self.movieArray[rightQuestion].title)", forState: .Normal)
			self.choiceFourButton.setTitle("\(self.movieArray[wrongQuestion3].title)", forState: .Normal)
			self.wrongAnswerLabel?.text = "WRONG!!! \r The Answer is: \r \r\r\(self.movieArray[rightQuestion].title) \r \(self.sumRightAnswers) Right Answers \r \(self.sumWrongAnswers) Wrong Answers"
			self.rightAnswerLabel?.text = "YOU GOT IT!!! \r \(self.sumRightAnswers) Right Answers \r \(self.sumWrongAnswers) Wrong Answers"
			self.rightAnswer = 3
		
		case 3:
			
			self.questionLabel?.text = "\(self.movieArray[rightQuestion].overview)"
			self.choiceOneButton.setTitle("\(self.movieArray[wrongQuestion1].title)", forState: .Normal)
			self.choiceTwoButton.setTitle("\(self.movieArray[wrongQuestion2].title)", forState: .Normal)
			self.choiceThreeButton.setTitle("\(self.movieArray[wrongQuestion3].title)", forState: .Normal)
			self.choiceFourButton.setTitle("\(self.movieArray[rightQuestion].title)", forState: .Normal)
			self.wrongAnswerLabel?.text = "WRONG!!! \r The Answer is: \r\r\r \(self.movieArray[rightQuestion].title) \r \(self.sumRightAnswers) Right Answers \r \(self.sumWrongAnswers) Wrong Answers"
			self.rightAnswerLabel?.text = "YOU GOT IT!!! \r \(self.sumRightAnswers) Right Answers \r \(self.sumWrongAnswers) Wrong Answers"
			self.rightAnswer = 4
			
		default:
			self.questionLabel?.text = "\(self.movieArray[rightQuestion].overview)"
			self.choiceOneButton.setTitle("\(self.movieArray[wrongQuestion1].title)", forState: .Normal)
			self.choiceTwoButton.setTitle("\(self.movieArray[wrongQuestion2].title)", forState: .Normal)
			self.choiceThreeButton.setTitle("\(self.movieArray[rightQuestion].title)", forState: .Normal)
			self.choiceFourButton.setTitle("\(self.movieArray[wrongQuestion3].title)", forState: .Normal)
			self.wrongAnswerLabel?.text = "WRONG!!! \r The Answer is: \r \r\r\(self.movieArray[rightQuestion].title) \r \(self.sumRightAnswers) Right Answers \r \(self.sumWrongAnswers) Wrong Answers"
			self.rightAnswerLabel?.text = "YOU GOT IT!!! \r \(self.sumRightAnswers) Right Answers \r \(self.sumWrongAnswers) Wrong Answers"
			self.rightAnswer = 3
	
			}
	
	}
	
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
	
	func showWrongAnswerScreen(){
		self.wrongAnswerLabel.hidden = false
	
	}
	
	func hideWrongAnswerScreen(){
		self.wrongAnswerLabel.hidden = true
	}
	
	func hideRightAnswerScreen(){
	self.rightAnswerLabel.hidden = true
	}
	
	func showRightAnswerScreen(){
		self.rightAnswerLabel.hidden = false
	}
	
	
	func choiceOneButtonAction(btn:UIButton){
		
		if(self.rightAnswer == 1){
			self.hideButtons()
			self.showRightAnswerScreen()
			print("right")
		}
		else{
			self.hideButtons()
			self.showWrongAnswerScreen()
			print("wrong")
			
		}
	}
	func choiceTwoButtonAction(btn:UIButton){
		if(self.rightAnswer == 2){
			self.hideButtons()
			self.showRightAnswerScreen()
			print("right")
		}
		else{
			self.hideButtons()
			self.showWrongAnswerScreen()
			print("wrong")
		}
	}
	func choiceThreeButtonAction(btn:UIButton){
		if(self.rightAnswer == 3){
			self.hideButtons()
			self.showRightAnswerScreen()
			
			print("right")
		}
		else{
			self.hideButtons()
			self.showWrongAnswerScreen()
			print("wrong")
		}
	}
	func choiceFourButtonAction(btn:UIButton){
		if(self.rightAnswer == 4){
			self.hideButtons()
			self.showRightAnswerScreen()
			print("right")
		}
		else{
			self.hideButtons()
			self.showWrongAnswerScreen()
			print("wrong")
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

