//: [Previous](@previous)

import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

var workItem: DispatchWorkItem?

workItem = DispatchWorkItem {
    var count = 0
    
    while true {
        guard let workItem = workItem else {
            return
        }
        
        if workItem.isCancelled {
            print("Loop canceled")
            return
        }
        
        print("Loop \(count)")
        Thread.sleep(until: Date().addingTimeInterval(1))
        count += 1
    }
}


print("Start workItem")
DispatchQueue.global(qos: .utility).async(execute: workItem!)

Thread.sleep(until: Date().addingTimeInterval(10))

print("Cancel workItem")
workItem?.cancel()

Thread.sleep(until: Date().addingTimeInterval(10))

PlaygroundPage.current.finishExecution()

//: [Next](@next)
