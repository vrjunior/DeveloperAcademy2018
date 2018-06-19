//
//  BullsEyeTests.swift
//  BullsEyeTests
//
//  Created by Valmir Junior on 05/03/18.
//  Copyright © 2018 Ray Wenderlich. All rights reserved.
//

import XCTest
@testable import BullsEye

class BullsEyeTests: XCTestCase {
    
    var gameUnderTest: BullsEyeGame!
    
    override func setUp() {
        super.setUp()
        
        self.gameUnderTest = BullsEyeGame()
        self.gameUnderTest.startNewGame()

    }
    
    override func tearDown() {
        gameUnderTest = nil
        super.tearDown()
    }
    

    func testScoreIsComputed() {
        let guess = gameUnderTest.targetValue - 5
        
        _ = gameUnderTest.check(guess: guess)
        
        XCTAssertEqual(gameUnderTest.scoreRound, 95, "score computed from guess is wrong")
        
    }
    
    
}
