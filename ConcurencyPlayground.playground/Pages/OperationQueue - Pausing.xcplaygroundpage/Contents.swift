//: [Previous](@previous)

import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

class MyOperation: Operation {
    let id: String
    
    init(id: String) {
        self.id = id
        super.init()
    }
    
    override func main() {
        print("Start operation: \(id)")
        sleep(UInt32.random(in: 1...3))
        print("End operation: \(id)")
    }
}

let queue = OperationQueue()
queue.maxConcurrentOperationCount = 3
let operations = (1...10).map { MyOperation(id: "1 - \($0)") }

print("Start the first group of operations\n")
queue.addOperations(operations, waitUntilFinished: false)

print("\nPause operations\n")
queue.isSuspended = true

print("\nStart the second group of operations\n")

let operations2 = (1...10).map { MyOperation(id: "2 - \($0)") }
queue.addOperations(operations2, waitUntilFinished: false)
sleep(10)

print("\nResume operations\n")
queue.isSuspended = false

print("\nWait until all the operations will be finished\n")
queue.waitUntilAllOperationsAreFinished()
print("\nAll operations were finished\n")

PlaygroundPage.current.finishExecution()

//: [Next](@next)
