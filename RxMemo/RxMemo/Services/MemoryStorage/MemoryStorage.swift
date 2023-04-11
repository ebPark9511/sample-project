//
//  MemoryStorage.swift
//  RxMemo
//
//  Created by 박은비 on 2023/04/07.
//

import Foundation

import RxCocoa
import RxSwift

class MemoryStorage: MemoStorageType {
    
    private var list = [
        Memo(content: "Hello, RxSwift", insertDate: Date().addingTimeInterval(-10)),
        Memo(content: "Lorem, Ipsum", insertDate: Date().addingTimeInterval(-20)),
    ]
    
    var updated: BehaviorSubject<Void> = .init(value: Void())
    
    @discardableResult
    func createMemo(content: String) -> Memo {
        let memo = Memo(content: content)
        list.insert(memo, at: 0)
        
        self.updated.onNext(Void())
        
        return memo
    }
    
    @discardableResult
    func memoList() -> [Memo] {
        return list
    }
    
    @discardableResult
    func update(memo: Memo, content: String) -> Memo {
        let updatedMemo = Memo(original: memo, updatedContent: content)
        
        if let index = list.firstIndex(where: { $0 == memo }) {
            list.remove(at: index)
            list.insert(updatedMemo, at: index)
        }
        
        self.updated.onNext(Void())
        
        return updatedMemo
    }
    
    @discardableResult
    func delete(memo: Memo) -> Memo {
        if let index = list.firstIndex(where: { $0 == memo }) {
            list.remove(at: index)
        }
        
        self.updated.onNext(Void())
        
        return memo
    }
    
    
}
