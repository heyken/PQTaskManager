//
//  TaskActionable.swift
//  PQTaskManager
//
//  Created by sanggyu on 10/08/2019.
//

protocol TaskActionable {
    func runTask(param:Any?)
}

extension TaskActionable{
    public func nextTask(){
        TaskQueueScheduler.shard.nextTask()
    }
}

