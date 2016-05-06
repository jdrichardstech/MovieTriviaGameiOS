//
//  global.swift
//  MovieTriviaGame
//
//  Created by Devinci on 4/23/16.
//  Copyright © 2016 JDRichardsTech. All rights reserved.
//

import Foundation

class Main{
	

	var numberQuestionsAskedCount = 0
	var sumRightAnswers = 0
	var sumWrongAnswers = 0
	var totalPoints = 0
	//moviesForGame 19 and 20 reserved for replacing duplicate titles
	var moviesForGame1 = [1,2,3,4,5,6,7,8,9,10,11]
	var moviesForGame2 = [12,13,14,15,16,17,4,1,18,3,8]
	var moviesForGame3 = [2,4,6,8,10,12,14,16,17,13,5]
	var rightButtonProgression1 = [0,2,1,3,2,0,3,3,1,1,2]
	var rightButtonProgression2 = [3,0,1,2,2,0,3,2,0,0,3]
	var rightButtonProgression3 = [2,3,1,1,2,0,3,0,2,1,0]
	var gameNumber = 0
	
}

var mainInstance = Main()