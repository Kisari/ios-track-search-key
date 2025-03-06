//
//  KeyWordViewList.swift
//  ios-track-search-key
//
//  Created by Minh Truong on 3/3/25.
//

// View Model

import Foundation

class KeyWordStackViewModel: ObservableObject {
    private var KeyWordStackManager: KeyWordStackManager
    
    @Published var keyWordList: [KeyWord]
    @Published var currentSize: Int
    
    init(KeyWordStackManager: KeyWordStackManager = .init(capacity: 10)) {
        self.KeyWordStackManager = KeyWordStackManager
        self.keyWordList = KeyWordStackManager.getKeyWordList()
        self.currentSize = KeyWordStackManager.getCurrentSize()
    }
    
    private func updateViewState() {
        keyWordList = KeyWordStackManager.getKeyWordList()
        currentSize = KeyWordStackManager.getCurrentSize()
    }
    
    func processKeyWord(_ keyWord: KeyWord) {
        KeyWordStackManager.processKeyWord(keyWord)
        updateViewState()
    }
}
