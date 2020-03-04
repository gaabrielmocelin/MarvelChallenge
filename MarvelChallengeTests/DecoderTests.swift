//
//  DecoderTests.swift
//  MarvelChallengeTests
//
//  Created by Gabriel Mocelin on 04/03/20.
//  Copyright © 2020 Gabriel Mocelin. All rights reserved.
//

import XCTest
@testable import MarvelChallenge

class DecoderTests: XCTestCase {
    var decoder: JSONDecoder!
    
    override func setUp() {
        decoder = JSONDecoder()
    }

    override func tearDown() {
        decoder = nil
    }
        
    func testDecodeHeroesFromMarvel() {
        var chars: [Character] = []
        
        do {
            let result = try decoder.decode(MarvelResponse<Character>.self, from: charData)
            chars = result.data.results
        } catch {
            XCTFail(error.localizedDescription)
        }
        
        XCTAssertEqual(chars.count, 1)
        
        XCTAssertNotNil(chars[0].name)
        XCTAssertNotNil(chars[0].description)
        XCTAssertNotNil(chars[0].imageUrl)
    }
    
    func testDecodeComicsFromMarvel() {
        var comics: [Comic] = []
        
        do {
            let result = try decoder.decode(MarvelResponse<Comic>.self, from: comicData)
            comics = result.data.results
        } catch {
            XCTFail(error.localizedDescription)
        }
        
        XCTAssertEqual(comics.count, 1)
        
        XCTAssertNotNil(comics[0].title)
        XCTAssertNotNil(comics[0].imageUrl)
    }
    
    private let charData = """
    {
        "data": {
            "total": 1,
            "results": [
                {
                    "id": 101010,
                    "name": "Iron Man",
                    "description": "Iron man description",
                    "thumbnail":
                        {
                            "path": "gateway.marvel.com",
                            "extension": "jpg"
                        }
                }
            ]
        }
    }
    """.data(using: .utf8)!

    private let comicData = """
    {
        "data": {
            "total": 1,
            "results": [
                {
                    "id": 111111,
                    "title": "Avengers #1",
                    "thumbnail": {
                        "path": "gateway.marvel.com",
                        "extension": "jpg"
                    }
                }
            ]
        }
    }
    """.data(using: .utf8)!

}
