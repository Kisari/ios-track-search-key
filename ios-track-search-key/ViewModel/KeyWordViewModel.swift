//
//  KeyWordViewList.swift
//  ios-track-search-key
//
//  Created by Minh Truong on 3/3/25.
//

// View Model

import Foundation

final class KeyWordStackViewModel: ObservableObject {
    private var keyWordStackManager: KeyWordStackManager
    
    @Published var keyWordList: [KeyWord]
    @Published var currentSize: Int
    
    init(keyWordStackManager: KeyWordStackManager = .init(capacity: 10)) {
        self.keyWordStackManager = keyWordStackManager
        self.keyWordList = keyWordStackManager.getKeyWordList()
        self.currentSize = keyWordStackManager.getCurrentSize()
    }
    
    private func updateViewState() {
        keyWordList = keyWordStackManager.getKeyWordList()
        currentSize = keyWordStackManager.getCurrentSize()
    }
    
    func processKeyWord(_ keyWord: KeyWord) {
        keyWordStackManager.processKeyWord(keyWord)
        updateViewState()
    }
}
