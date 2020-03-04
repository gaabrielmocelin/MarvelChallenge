//
//  CharactersViewModelTests.swift
//  MarvelChallengeTests
//
//  Created by Gabriel Mocelin on 04/03/20.
//  Copyright © 2020 Gabriel Mocelin. All rights reserved.
//

import XCTest
@testable import MarvelChallenge

class CharactersViewModelTests: XCTestCase {
    
    var charactersViewModel: CharactersViewModel!
    var marvelService: MarvelAPIMock!

    override func setUp() {
        let coordinator = Coordinator(window: UIWindow())
        charactersViewModel = CharactersViewModel(coordinator: coordinator)
        marvelService = MarvelAPIMock()
        charactersViewModel.marvelService = marvelService
    }

    override func tearDown() {
        charactersViewModel = nil
    }

    func testSuccessfullCharactersFetch() {
        let expectation = self.expectation(description: "charactersFetch")
        var result: Result<[IndexPath], Error>?
        
        charactersViewModel.fetchCharacteres {
            result = $0
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        
        if case .success(let indexes) = result {
            XCTAssert(indexes.count > 0)
        } else {
            XCTFail()
        }
    }
    
    func testFailCharactersFetch() {
        marvelService.shouldFailRequests = true
        
        let expectation = self.expectation(description: "charactersFetch")
        var result: Result<[IndexPath], Error>?
        
        charactersViewModel.fetchCharacteres {
            result = $0
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        
        if case .success(_) = result {
            XCTFail("should have failed request")
        } else {
            XCTAssert(true)
        }
    }

}
