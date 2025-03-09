//
//  KeyWordDDLViewModel.swift
//  ios-track-search-key
//
//  Created by Minh Truong on 6/3/25.
//

import Foundation


final class KeyWordDDLViewModel: ObservableObject {
    private var KeyWordDDLManager: KeyWordDLLManager
    
    @Published var keyWordList: [KeyWord]
    @Published var currentSize: Int
    
    init(KeyWordDDLManager: KeyWordDLLManager = .init(capacity: 4)) {
        self.KeyWordDDLManager = KeyWordDDLManager
        self.keyWordList = KeyWordDDLManager.toArray()
        self.currentSize = KeyWordDDLManager.getCurrentSize()
    }
    
    private func updateViewState() {
        keyWordList = KeyWordDDLManager.toArray()
        currentSize = KeyWordDDLManager.getCurrentSize()
    }
    
    func processKeyWord(_ keyWord: KeyWord) {
        KeyWordDDLManager.processKeyWord(keyWord)
        updateViewState()
    }
}
