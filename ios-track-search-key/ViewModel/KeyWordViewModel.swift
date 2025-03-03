//
//  KeyWordViewList.swift
//  ios-track-search-key
//
//  Created by Minh Truong on 3/3/25.
//

import Foundation

class KeyWordViewModel: ObservableObject {
    private var keyWordManager: KeyWordManager
    
    @Published var keyWordList: [KeyWord]
    @Published var currentSize: Int
    
    init(keyWordManager: KeyWordManager = KeyWordManager()) {
        self.keyWordManager = keyWordManager
        self.keyWordList = keyWordManager.getKeyWordList()
        self.currentSize = keyWordManager.getCurrentSize()
    }
    
    private func updateViewState() {
        keyWordList = keyWordManager.getKeyWordList()
        currentSize = keyWordManager.getCurrentSize()
    }
    
    func processKeyWord(_ keyWord: KeyWord) {
        keyWordManager.processKeyWord(keyWord)
        updateViewState()
    }
}
