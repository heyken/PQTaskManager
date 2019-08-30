//
//  TaskPack.swift
//  PQTaskManager
//
//  Created by sanggyu on 10/08/2019.
//

func ==(lhs: TaskPack, rhs: TaskPack) -> Bool { return lhs.task.myRank == rhs.task.myRank }
func <(lhs: TaskPack, rhs: TaskPack) -> Bool  { return lhs.task.myRank < rhs.task.myRank }

protocol Task {
    var action:TaskActionable   { get }
    var myRank:Int              { get }
}

struct TaskPack : Comparable {
    let task    : TaskRankElement
    let param   : Any?
}
