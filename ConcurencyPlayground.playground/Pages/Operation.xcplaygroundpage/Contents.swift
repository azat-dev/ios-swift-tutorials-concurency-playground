//: [Previous](@previous)

import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

class MyOperation: Operation {
    private let id: String
    
    init(id: String) {
        self.id = id
    }
    
    override func main() {
        print("Start MyOperation: \(id)")
        sleep(2)
        print("End MyOperation: \(id)")
    }
}


let operation = MyOperation(id: "1")
operation.start()

PlaygroundPage.current.finishExecution()

//: [Next](@next)
