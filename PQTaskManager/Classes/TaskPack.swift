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


////////////
import Foundation
enum TaskRankElement:Int, Task {
    case myRankA
    case myRankB
    case myRankC
    case myRankD
    case myRankE
    
    var myRank:Int { return self.rawValue }
    var action:TaskActionable {
        switch self {
        case .myRankA:
            return TaskA()
        case .myRankB:
            return TaskB()
        case .myRankC:
            return TaskC()
        case .myRankD:
            return TaskD()
        case .myRankE:
            return TaskE()
        }
    }
}

extension TaskRankElement {
    fileprivate struct TaskA: TaskActionable {
        func runTask(param: Any?) {
            print("task A")
            self.nextTask()
        }
    }
    
    fileprivate struct TaskB: TaskActionable {
        func runTask(param: Any?) {
            //execute async, but turn next task by nextTask()
            //this is async logic for test
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.25) {
                print("task B")
                self.nextTask()
            }
        }
    }
    
    fileprivate struct TaskC: TaskActionable {
        func runTask(param: Any?) {
            print("task C")
            self.nextTask()
        }
    }
    
    fileprivate struct TaskD: TaskActionable {
        func runTask(param: Any?) {
            //execute async, but turn next task by nextTask()
            //this is async logic for test
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.35) {
                print("task D")
                self.nextTask()
            }
        }
    }
    
    fileprivate struct TaskE: TaskActionable {
        func runTask(param: Any?) {
            print("task E")
            self.nextTask()
        }
    }
}



