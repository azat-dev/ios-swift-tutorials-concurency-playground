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
        print("End operations: \(id)")
    }
}

let queue = OperationQueue()

for id in 1...10 {
    let operation = MyOperation(id: String(id))
    queue.addOperation(operation)
}

print("\nBlock thread until all operations will be finished\n")
queue.waitUntilAllOperationsAreFinished()
print("\nAll operations were finished\n")


PlaygroundPage.current.finishExecution()

//: [Next](@next)
