//: [Previous](@previous)

import Foundation
import PlaygroundSupport
import UIKit
import CoreImage

PlaygroundPage.current.needsIndefiniteExecution = true

// MARK: - Async Operation
class AsyncOperation: Operation {
    var state = State.ready {
        willSet {
            willChangeValue(forKey: newValue.keyPath)
            willChangeValue(forKey: state.keyPath)
        }
        didSet {
            didChangeValue(forKey: oldValue.keyPath)
            didChangeValue(forKey: state.keyPath)
        }
    }
    
    override var isReady: Bool {
        return super.isReady && state == .ready
    }
    override var isExecuting: Bool {
        return state == .executing
    }
    override var isFinished: Bool {
        return state == .finished
    }
    
    override var isAsynchronous: Bool {
        return true
    }
    
    override func start() {
      main()
      state = .executing
    }
}

extension AsyncOperation {
    enum State: String {
        case ready, executing, finished
        fileprivate var keyPath: String {
            return "is\(rawValue.capitalized)"
        }
    }
}



struct ListItem: Codable {
    let author: String
    let url: String
    let download_url: String
}

protocol ListDataProvider {
    var listData: [ListItem]? { get }
}

class ListDownloadOperation: Operation, ListDataProvider {
    var listData: [ListItem]?
    let url: URL!
    
    init(url: String) {
        self.url = URL(string: url)!
    }
    
    override func main() {
        guard let data = try? Data(contentsOf: url) else {
            return
        }
        
        let decoder = JSONDecoder()
        guard let list = try? decoder.decode([ListItem].self, from: data) else {
            return
        }
        
        listData = list
    }
}

protocol ImageDataProvider {
    var image: UIImage? { get }
}

class DownloadImageOperation: Operation, ImageDataProvider {
    var url: URL?
    var image: UIImage?
    
    init(url: String? = nil) {
        self.url = url == nil ? nil : URL(string: url!)
        super.init()
    }
    
    override func main() {
        let url: URL
        
        if self.url != nil {
            url = self.url!
        } else {
            guard
                let dataProvider = dependencies.first as? ListDataProvider,
                let listData = dataProvider.listData,
                let listItem = listData.first,
                let listItemUrl = URL(string: listItem.download_url)
            else {
                return
            }
            
            url = listItemUrl
        }

        print("Start image download")
        print("URL: \(url)")
        guard let data = try? Data(contentsOf: url) else {
            return
        }
        image = UIImage(data: data)
        print("Finish image download")
        if let image = image {
            print(image)
        }
    }
}


class ImageEffectOperation: Operation {
    private var inputImage: UIImage?
    var outputImage: UIImage?
    
    init(image: UIImage? = nil) {
        inputImage = image
    }
    
    override func main() {
        let context = CIContext()
        let inputImage: UIImage
        
        if self.inputImage != nil {
            inputImage = self.inputImage!
        } else {
            guard let dependencyImage = (dependencies.first as? ImageDataProvider)?.image else {
                return
            }
            
            inputImage = dependencyImage
        }
        

        guard
            let filter = CIFilter(name: "CITwirlDistortion")
        else {
            return
        }
        
        print("Start image effect")
        print(inputImage)
        
        let beginImage = CIImage(image: inputImage)
        filter.setValue(beginImage, forKey: kCIInputImageKey)
        filter.setValue(1, forKey: kCIInputRadiusKey)
        
        guard let image = filter.outputImage else {
            return
        }
        
        guard let cgImage = context.createCGImage(image, from: image.extent) else {
            return
        }
        
        outputImage = UIImage(cgImage: cgImage)
        print("Finish image effect")
        print(outputImage)
    }
}

let queue = OperationQueue()

let listOperation = ListDownloadOperation(url: "https://picsum.photos/v2/list?page=1&limit=10")

let downloadImageOperation = DownloadImageOperation()
downloadImageOperation.addDependency(listOperation)

let imageEffectOperation = ImageEffectOperation()
imageEffectOperation.addDependency(downloadImageOperation)

queue.addOperation(listOperation)
queue.addOperation(downloadImageOperation)
queue.addOperation(imageEffectOperation)

print("Wait for all operations")
queue.waitUntilAllOperationsAreFinished()
print("All operations finished")

PlaygroundPage.current.finishExecution()

//: [Next](@next)
