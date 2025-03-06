//
//  ios_track_search_keyTests.swift
//  ios-track-search-keyTests
//
//  Created by Minh Truong on 3/3/25.
//

@testable import ios_track_search_key
import XCTest

final class ios_track_search_keyTests: XCTestCase {
    private let mockData: [KeyWord] = [
        KeyWord(key: "apple"),
        KeyWord(key: "banana"),
        KeyWord(key: "cherry"),
        KeyWord(key: "date"),
        KeyWord(key: "elephant")
    ]

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

//    1    "apple" ->    ["apple"]
//    2    "banana"     ->["banana", "apple"]
//    3    "cherry"    ->["cherry", "banana", "apple"]
//    4    "banana"    ->["banana", "cherry", "apple"] (di chuyển "banana" lên đầu)
//    5    "date"->    ["date", "banana", "cherry"] (loại "apple")
//    6    "elephant"->    ["elephant", "date", "banana"] (loại "cherry")

    // MARK: - Test Case 1: Success adding 3 new keys to fullfill the capacity

    func testAddingFullfilKeyWordSuccess() {
        let KeyWordStackManager: KeyWordStackManager = .init(capacity: 3)

        KeyWordStackManager.processKeyWord(mockData[0])
        KeyWordStackManager.processKeyWord(mockData[1])
        KeyWordStackManager.processKeyWord(mockData[2])

        XCTAssertTrue(KeyWordStackManager.getCurrentSize() == 3, "Error: Expected true with 3 items in total")

        XCTAssertEqual(
            KeyWordStackManager.getKeyWordList()[1].key,
            mockData[1].key,
            "Error: Expected key with the same name"
        )
    }

    // MARK: - Test Case 2: Success swap the existing key in front WHEN FULL

    func testSwapExistingKeyWordWhenFullSuccess() {
        let KeyWordStackManager: KeyWordStackManager = .init(capacity: 3)

        KeyWordStackManager.processKeyWord(mockData[0])
        KeyWordStackManager.processKeyWord(mockData[1])
        KeyWordStackManager.processKeyWord(mockData[2])

        // Move banana to the front
        KeyWordStackManager.processKeyWord(mockData[1])
        XCTAssertEqual(
            KeyWordStackManager.getKeyWordList()[0].key,
            "banana",
            "Error: Expected key 'banana' must in front of the list"
        )
    }

    // test add an existing key when not full

    // MARK: - Test Case 3: Success swap the existing key in front WHEN NOT FULL

    func testSwapExistingKeyWordWhenNotFullSuccess() {
        let KeyWordStackManager: KeyWordStackManager = .init(capacity: 4)

        KeyWordStackManager.processKeyWord(mockData[0])
        KeyWordStackManager.processKeyWord(mockData[1])
        KeyWordStackManager.processKeyWord(mockData[2])

        // Move apple to the front
        KeyWordStackManager.processKeyWord(mockData[0])
        XCTAssertEqual(
            KeyWordStackManager.getKeyWordList()[0].key,
            "apple",
            "Error: Expected key 'apple' must in front of the list"
        )
    }

    // test add new key when full
    // MARK: - Test Case 4: Success add new key word WHEN FULL

    func testAddKeyWordWhenFullSuccess() {
        let KeyWordStackManager: KeyWordStackManager = .init(capacity: 3)

        KeyWordStackManager.processKeyWord(mockData[0])
        KeyWordStackManager.processKeyWord(mockData[1])
        KeyWordStackManager.processKeyWord(mockData[2])

        // Add new "date" key word
        KeyWordStackManager.processKeyWord(mockData[3])
        XCTAssertEqual(
            KeyWordStackManager.getKeyWordList()[0].key,
            "date",
            "Error: Expected key 'date' must be added in front of the list"
        )
        
        // Add new "elephant" key word
        KeyWordStackManager.processKeyWord(mockData[4])
        XCTAssertEqual(
            KeyWordStackManager.getKeyWordList()[0].key,
            "elephant",
            "Error: Expected key 'elephant' must be added in front of the list"
        )
    }

    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
