//
//  TaskPack.swift
//  PQTaskManager
//
//  Created by sanggyu on 10/08/2019.
//

public func ==(lhs: TaskPack, rhs: TaskPack) -> Bool { return lhs.taskRank.priority == rhs.taskRank.priority }
public func <(lhs: TaskPack, rhs: TaskPack) -> Bool  { return lhs.taskRank.priority < rhs.taskRank.priority }

public protocol TaskRank {
    var priority    : Int               { get }
    var taskAction  : TaskActionable    { get }
}

public struct TaskPack : Comparable {
    let taskRank    : TaskRank
    let param       : Any?
    
    public init(taskRank:TaskRank, param:Any?) {
        self.taskRank = taskRank
        self.param = param
    }
}

