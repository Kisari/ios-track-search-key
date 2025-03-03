//
//  KeyWordManager.swift
//  ios-track-search-key
//
//  Created by Minh Truong on 3/3/25.
//

import Foundation

protocol KeyWordStack {
    func getCurrentSize() -> Int
    func getKeyWordList() -> [KeyWord]
    func addKeyWord(_ keyWord: KeyWord)
    func removeAtIndex(_ index: Int)
    func searchInList(_ keyWord: KeyWord) -> Int
}

class KeyWordManager: KeyWordStack {
    struct Configuration {
        let capacity: Int
    }
    
    private var config: Configuration
    public var keyWordList: [KeyWord]
    public var currentSize: Int
  
    init(capacity: Int = 10) {
        self.config = Configuration(capacity: capacity)
        self.keyWordList = []
        self.currentSize = 0
    }
    
    func getCurrentSize() -> Int {
        return currentSize
    }
    
    func getKeyWordList() -> [KeyWord]{
        return keyWordList
    }
    
    // Add a new keyword, maintaining the size constraint
    func addKeyWord(_ keyWord: KeyWord) {
        keyWordList.insert(keyWord, at: 0)
        if currentSize < config.capacity {
            currentSize += 1
        } else {
            // Remove the last keyword if exceeding capacity
            keyWordList.removeLast()
        }
    }
    
    // Run the search function
    func processKeyWord(_ keyWord: KeyWord) {
        let elementIndex = searchInList(keyWord)
        if elementIndex != -1 {
            // Remove keyword from current position
            removeAtIndex(elementIndex)
        }

        addKeyWord(keyWord)
    }
    
    // Remove keyword at the specific index
    func removeAtIndex(_ index: Int) {
        keyWordList.remove(at: index)
        currentSize -= 1
    }
    
    // Search for keyword in the list -> return -1 if not found
    func searchInList(_ keyWord: KeyWord) -> Int {
        return keyWordList.firstIndex(where: { $0.key == keyWord.key }) ?? -1
    }
}
