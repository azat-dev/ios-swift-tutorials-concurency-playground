//: [Previous](@previous)

import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

var workItem: DispatchWorkItem?
    
workItem = DispatchWorkItem {
    print("workItem block: start execution")
    Thread.sleep(until: Date().addingTimeInterval(5))
    print("workItem block: stop execution")
}

let completionHandler = DispatchWorkItem {
    print("Notification: work item completed")
}

print("Connect completion handler")
workItem?.notify(queue: DispatchQueue.global(qos: .background), execute: completionHandler)

DispatchQueue.global(qos: .background).async(execute: workItem!)

print("Wait for the end")
Thread.sleep(until: Date().addingTimeInterval(20))
print("Finish Playground")

PlaygroundPage.current.finishExecution()

//: [Next](@next)
