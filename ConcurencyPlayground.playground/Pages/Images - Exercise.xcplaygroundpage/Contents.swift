//: [Previous](@previous)

import Foundation
import PlaygroundSupport
import UIKit

PlaygroundPage.current.needsIndefiniteExecution = true

struct ImageInfo: Codable {
    let author: String
    let url: String
    let download_url: String
}


func loadUrls() -> [URL] {
    guard let url = URL(string: "https://picsum.photos/v2/list?page=1&limit=100") else {
        fatalError("Wrong url")
    }
    
    guard let data = try? Data(contentsOf: url) else {
        fatalError("Can't download urls")
    }
    
    let decoder = JSONDecoder()
    
    guard let loadedItems = try? decoder.decode([ImageInfo].self, from: data) else {
        fatalError("Can't parse loaded urls")
    }
    
    return loadedItems.compactMap { URL(string: $0.download_url) }
}

let urls = loadUrls()
print("Urls: \(urls.count)")

func downloadImages(urls: [URL]) -> [UIImage] {
    let maxNumberofActiveRequests = 5
    var images = [UIImage?]()
    let group = DispatchGroup()
    
    func downloadImage(url: URL) -> UIImage? {
        defer {
            group.leave()
        }
        
        guard let data = try? Data(contentsOf: url) else {
            print("Can't download image: \(url)")
            return nil
        }
        
        return UIImage(data: data)
    }
    
    
    var numberOfActiveRequests = 0
    
    for (index, url) in urls.enumerated() {
        if numberOfActiveRequests == 0 {
            print("\nStart new group\n")
        }
        
        let isLast = index == urls.count - 1
        
        print("Push to queue image loading: \(index)")
        
        DispatchQueue.global(qos: .utility).async(group: group) {
            group.enter()
            print("Start image loading: \(index)")
            let image = downloadImage(url: url)
            print("Image loaded: \(index)")
            images.append(image)
        }
        
        numberOfActiveRequests += 1
        
        if numberOfActiveRequests == maxNumberofActiveRequests || isLast {
            print("\nWaiting to load group: \(numberOfActiveRequests)\n")
            group.wait()
            numberOfActiveRequests = 0
        }
    }
    
    return images.compactMap { $0 }
}

let images = downloadImages(urls: urls)
print(images)

print("Waiting...")
Thread.sleep(until: Date().addingTimeInterval(30))
print("\nStop playground\n")

PlaygroundPage.current.finishExecution()

//: [Next](@next)
