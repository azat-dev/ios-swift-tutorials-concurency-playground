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

print("Wait")

if group.wait(timeout: .now() + 3) == .success {
    print("Tasks were finished")
} else {
    print("Timedout")
}

print("Waiting...")
Thread.sleep(until: Date().addingTimeInterval(30))
print("\nStop playground\n")

PlaygroundPage.current.finishExecution()

//: [Next](@next)
