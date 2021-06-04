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
    let requestsSemaphore = DispatchSemaphore(value: 5)
    let imagesSemaphore = DispatchSemaphore(value: 1)
    var images = [UIImage?]()
    let group = DispatchGroup()
    
    func appendDownloadedImage(_ image: UIImage) {
        defer { imagesSemaphore.signal() }
        
        imagesSemaphore.wait()
        images.append(image)
    }
    
    func downloadImage(url: URL) -> UIImage? {
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
        
        return UIImage(data: data)
    }
    
    for (index, url) in urls.enumerated() {
        if index % 5 == 0 {
           print("\nNew group\n")
        }
        
        requestsSemaphore.wait()
        
        print("Push image loading to queue: \(index)")
        DispatchQueue.global(qos: .utility).async(group: group) {
            defer {
                requestsSemaphore.signal()
            }
            
            print("Start image loading: \(index)")
            guard let image = downloadImage(url: url) else {
                print("Failed to load image: \(index)")
                return
            }
            
            appendDownloadedImage(image)
            print("Image loaded: \(index)")
        }
    }
    
    group.wait()
    
    return images.compactMap { $0 }
}

let images = downloadImages(urls: urls)
print(images)

print("Waiting...")
Thread.sleep(until: Date().addingTimeInterval(30))
print("\nStop playground\n")

PlaygroundPage.current.finishExecution()

//: [Next](@next)
