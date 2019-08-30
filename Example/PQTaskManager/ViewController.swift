//
//  ViewController.swift
//  PQTaskManager
//
//  Created by heyken on 08/30/2019.
//  Copyright (c) 2019 heyken. All rights reserved.
//

import UIKit
import Foundation
import PQTaskManager

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        runElement()
    }

    func runElement() {
        //enqueue randomly , but execute by rank
        TaskQueueScheduler.shard.enQueueTask(pack: TaskPack(taskRank: TestRankTasks.myRankC,   param:nil))
        TaskQueueScheduler.shard.enQueueTask(pack: TaskPack(taskRank: TestRankTasks.myRankA,   param:nil))
        TaskQueueScheduler.shard.enQueueTask(pack: TaskPack(taskRank: TestRankTasks.myRankE,   param:nil))
        TaskQueueScheduler.shard.enQueueTask(pack: TaskPack(taskRank: TestRankTasks.myRankD,   param:nil))
        TaskQueueScheduler.shard.enQueueTask(pack: TaskPack(taskRank: TestRankTasks.myRankB,   param:nil))
        
        TaskQueueScheduler.shard.startTask()
    }

}

enum TestRankTasks:Int {
    case myRankA
    case myRankB
    case myRankC
    case myRankD
    case myRankE
}

extension TestRankTasks:TaskRank {
    var priority: Int { return self.rawValue }
    var taskAction: TaskActionable {
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

