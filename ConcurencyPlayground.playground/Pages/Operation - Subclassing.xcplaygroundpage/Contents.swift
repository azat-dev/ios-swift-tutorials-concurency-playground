//: [Previous](@previous)

import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

class MyOperation: Operation {
    private let id: String
    
    init(id: String) {
        self.id = id
        super.init()
    }
    
    override func main() {
        print("Start MyOperation: \(id)")
        sleep(2)
        print("End MyOperation: \(id)")
    }
}


let operation = MyOperation(id: "1")

print("Block the currrent thread untill it the operation won't be finished\n")
operation.start()
print("\nThe operation is finished")

PlaygroundPage.current.finishExecution()

//: [Next](@next)
