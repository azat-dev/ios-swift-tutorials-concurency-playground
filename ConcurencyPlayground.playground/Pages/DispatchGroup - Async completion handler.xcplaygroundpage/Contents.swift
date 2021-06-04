//: [Previous](@previous)
import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let group = DispatchGroup()

DispatchQueue.global(qos: .background).async(group: group) {
    print("Start task1")
    Thread.sleep(until: Date().addingTimeInterval(2))
    print("Stop task1")
}

DispatchQueue.global(qos: .background).async(group: group) {
    print("Start task2")
    Thread.sleep(until: Date().addingTimeInterval(5))
    print("Stop task2")
}


group.notify(queue: DispatchQueue.global(qos: .background)) {
    print("\nGroup notification\n")
}

print("\nWaiting....\n")
Thread.sleep(until: Date().addingTimeInterval(30))
print("\nStop playground")

PlaygroundPage.current.finishExecution()

//: [Next](@next)
