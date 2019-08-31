PQTaskManager is a continuous task manager by priority queue

It is managed by task rank

The task priority is defined enum case

# PQTaskManager

[![CI Status](https://img.shields.io/travis/heyken/PQTaskManager.svg?style=flat)](https://travis-ci.org/heyken/PQTaskManager)
[![Version](https://img.shields.io/cocoapods/v/PQTaskManager.svg?style=flat)](https://cocoapods.org/pods/PQTaskManager)
[![License](https://img.shields.io/cocoapods/l/PQTaskManager.svg?style=flat)](https://cocoapods.org/pods/PQTaskManager)
[![Platform](https://img.shields.io/cocoapods/p/PQTaskManager.svg?style=flat)](https://cocoapods.org/pods/PQTaskManager)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

PQTaskManager is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'PQTaskManager'
```

## How to Use
Step 1.
define enum case and function for task rank

implement your task logic in runTask(param:Any?)

if you want move next task, use nextTask()
```ruby
enum TestRankTasks:Int {
    case myRankA
    case myRankB
    case myRankC
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
}
```

Step 2.
Use enQueue for insert queue buffer
```ruby
 TaskQueueScheduler.shard.enQueueTask(pack: TaskPack(taskRank: TestRankTasks.myRankC,   param:nil))
 TaskQueueScheduler.shard.enQueueTask(pack: TaskPack(taskRank: TestRankTasks.myRankA,   param:nil))
 TaskQueueScheduler.shard.enQueueTask(pack: TaskPack(taskRank: TestRankTasks.myRankB,   param:nil))
```

 and Start Task function
 
 ```ruby
 TaskQueueScheduler.shard.startTask()
```


## Author

heyken(sheldon), roulette56power@gmail.com

## License

PQTaskManager is available under the MIT license. See the LICENSE file for more info. 
