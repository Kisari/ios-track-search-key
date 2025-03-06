//
//  KeyWordDoubleLinkedList.swift
//  ios-track-search-key
//
//  Created by Minh Truong on 5/3/25.
//

import Foundation

class KeyWordNode: Equatable {
    var value: KeyWord
    var next: KeyWordNode?
    var prev: KeyWordNode?

    init(_ value: KeyWord, _ next: KeyWordNode?, _ prev: KeyWordNode?) {
        self.value = value
        self.next = next
        self.prev = prev
    }
    
    static func ==(leftNode: KeyWordNode, rightNode: KeyWordNode) -> Bool {
        return leftNode.value.key == rightNode.value.key
    }
}

class KeyWordDLLManager {
    struct Configuration {
        let capacity: Int
    }
    
    private var head: KeyWordNode?
    private var tail: KeyWordNode?
    private var config: Configuration
    private var currentSize: Int
    
    init(capacity: Int) {
        self.config = .init(capacity: capacity)
        self.currentSize = 0
        self.head = nil
        self.tail = head
    }
    
    func getCurrentSize() -> Int {
        return currentSize
    }
    
    func isEmpty() -> Bool {
        return head == nil
    }
    
    func DDLToArray() -> [KeyWord] {
        var result = [KeyWord]()
        var currentNode = head
        
        while let node = currentNode {
            result.append(node.value)
            currentNode = node.next
        }
        
        return result
    }
    
    func insertAtFront(_ keyWord: KeyWord) {
        if isEmpty() {
            head = KeyWordNode(keyWord, nil, nil)
            tail = head
        }
        else {
            let newKeyWordNode = KeyWordNode(keyWord, head, nil)
            
            head?.prev = newKeyWordNode
            head = newKeyWordNode
        }
        currentSize = currentSize + 1
    }
    
    func removeLast() {
        guard let tailNode = tail, let headNode = head else { return }
        if tailNode == headNode {
            tail = nil
            head = nil
        }
        else if let prev = tailNode.prev {
            tail = prev
            tail?.next = nil
        }
        currentSize = currentSize -
            1
    }
    
    func findAndRemoveTheNode(_ keyWord: KeyWord) -> KeyWordNode? {
        var currentNode = head
        
        while let node = currentNode {
            if node.value.key == keyWord.key {
                if node === head {
                    head = node.next
                    head?.prev = nil
                }
                else if node === tail {
                    tail = node.prev
                    tail?.next = nil
                }
                else {
                    node.prev?.next = node.next
                    node.next?.prev = node.prev
                }
                currentSize = currentSize -
                    1
                return node
            }
            currentNode = node.next
        }
        
        return nil
    }
    
    func processKeyWord(_ keyWord: KeyWord) {
        if let removedNode = findAndRemoveTheNode(keyWord) {
            insertAtFront(removedNode.value)
            return
        }
        
        if currentSize < config.capacity {
            insertAtFront(keyWord)
        }
        else {
            removeLast()
            insertAtFront(keyWord)
        }
    }
}
