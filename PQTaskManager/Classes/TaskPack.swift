//
//  TaskPack.swift
//  PQTaskManager
//
//  Created by sanggyu on 10/08/2019.
//

func ==(lhs: TaskPack, rhs: TaskPack) -> Bool { return lhs.taskRank.priority == rhs.taskRank.priority }
func <(lhs: TaskPack, rhs: TaskPack) -> Bool  { return lhs.taskRank.priority < rhs.taskRank.priority }

protocol TaskRank {
    var priority    : Int               { get }
    var taskAction  : TaskActionable    { get }
}

struct TaskPack : Comparable {
    let taskRank    : TaskRank
    let param       : Any?
}

