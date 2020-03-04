//
//  CharacterDetailViewModelTests.swift
//  MarvelChallengeTests
//
//  Created by Gabriel Mocelin on 04/03/20.
//  Copyright © 2020 Gabriel Mocelin. All rights reserved.
//

import XCTest
@testable import MarvelChallenge

class CharacterDetailViewModelTests: XCTestCase {

    var characterDetailViewModel: CharacterDetailViewModel!
    var marvelService: MarvelAPIMock!

    override func setUp() {
        marvelService = MarvelAPIMock()
        
        let coordinator = Coordinator(window: UIWindow())
        characterDetailViewModel = CharacterDetailViewModel(coordinator: coordinator,
                                                            character: marvelService.char3,
                                                            marvelService: marvelService,
                                                            imageService: ImageServiceMock())
    }

    override func tearDown() {
        characterDetailViewModel = nil
    }

    func testSuccessfullComicsFetch() {
        let expectation = self.expectation(description: "comicsFetch")
        var result: Error?
        
        characterDetailViewModel.fetchComics {
            result = $0
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        
        if result == nil {
            XCTAssert(true)
        } else {
            XCTFail()
        }
    }
    
    func testFailComicsFetch() {
        marvelService.shouldFailRequests = true
        
        let expectation = self.expectation(description: "comicsFetch")
        var result: Error?
        
        characterDetailViewModel.fetchComics {
            result = $0
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        
        if result == nil {
            XCTFail("should have failed request")
        } else {
            XCTAssert(true)
        }
    }
    
    func testCharacterImageDownload() {
        let expectation = self.expectation(description: "imageFetch")
        var result: UIImage?
        
        characterDetailViewModel.fetchImage {
            result = $0
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        
        if result != nil {
            XCTAssert(true)
        } else {
            XCTFail()
        }
    }
}
