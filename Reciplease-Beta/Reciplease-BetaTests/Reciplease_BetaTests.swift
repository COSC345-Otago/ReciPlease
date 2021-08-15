//
//  Reciplease_BetaTests.swift
//  Reciplease-BetaTests
//
//  Created by Tim Copland on 15/08/21.
//  Copyright © 2021 Samuel Royal. All rights reserved.
//

import XCTest
@testable import Reciplease_Beta

class Reciplease_BetaTests: XCTestCase {
    
    func testIngredientsFilled() {
        let miss = Data.fillProds()
        sleep(3)
        print(miss)
        XCTAssert(Data.Ingredients.count > 0, "No ingredients have been put into array")
    }
    
//    func testUrls() {
//        Data.fillProds()
//        sleep(3)
//        
//    }
    
    func testMissingReci() {
        let miss = Data.fillProds()
        sleep(3)
        XCTAssert(miss.count == 1, "Missing relation?")
    }
    
    // test adding recipe
    
}
