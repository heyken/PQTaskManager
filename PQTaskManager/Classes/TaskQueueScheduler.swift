//
//  TaskQueueScheduler.swift
//  PQTaskManager
//
//  Created by sanggyu on 10/08/2019.
//

import Foundation
import SwiftPriorityQueue

protocol TaskQueueSchedulerType {
    associatedtype T
    
    func startTask()
    func nextTask()
    func removeAllTask()
    func isEmpty() -> Bool
    
    func enQueueTask(pack:T)
    func peekQueueTask() -> T?
    func deQueueTask()
}

class TaskQueueScheduler : NSObject {
    static public var shard = TaskQueueScheduler()
    
    typealias Pack = TaskPack
    var priorityQueue = PriorityQueue<Pack>(ascending: true)
    var queuingCache = [Int:Bool]() //to use that It's not permite about duplicated element
    var runningPack:Pack?
    
    override init() {
        super.init()
        PQNotification.addNoti { [weak self] object in
            guard let self = self else { return }
            let pack = self.peekQueueTask()
            self.taskAction(pack: pack, param:pack?.param)
        }
    }
    
    private func taskAction(pack: Pack?, param:Any?) {
        guard let pack = pack else { return }
        if self.runningPack != pack {
            self.runningPack = pack
            
            DispatchQueue.main.async {
                pack.taskRank.taskAction.runTask(param: param)
            }
        }
    }
}

extension TaskQueueScheduler:TaskQueueSchedulerType {
    func startTask(){
        print("**** start queue ****")
        PQNotification.post()
    }
    
    func nextTask() {
        self.deQueueTask()
        PQNotification.post()
    }
    
    public func isEmpty() -> Bool {
        return priorityQueue.isEmpty
    }
    
    public func peekQueueTask() -> Pack? {
        let task = priorityQueue.peek()
        return task
    }
    
    public func deQueueTask() {
        let task = priorityQueue.pop()
        if let r = task?.taskRank.priority {
            queuingCache[r] = false
        }
        self.runningPack = nil
    }
    
    public func enQueueTask(pack: Pack) {
        if queuingCache[pack.taskRank.priority] != true {
            queuingCache[pack.taskRank.priority] = true
            priorityQueue.push(pack)
        }
    }
    
    public func removeAllTask() {
        queuingCache = [Int:Bool]()
        runningPack = nil
        priorityQueue.clear()
    }
}

