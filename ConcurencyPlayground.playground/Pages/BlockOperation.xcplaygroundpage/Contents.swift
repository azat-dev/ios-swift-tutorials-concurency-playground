//: [Previous](@previous)

import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true


let blockOperation = BlockOperation()
blockOperation.completionBlock = {
    print("\nThe block operation was completed\n")
}

for index in 0...30 {
    blockOperation.addExecutionBlock {
        print(index)
        sleep(2)
    }
}

let startTime = Date()
blockOperation.start()
print("Total duration: \(Date().timeIntervalSince(startTime))")


PlaygroundPage.current.finishExecution()
//: [Next](@next)
