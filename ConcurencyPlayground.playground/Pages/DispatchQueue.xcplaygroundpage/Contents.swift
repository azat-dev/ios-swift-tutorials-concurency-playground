//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

struct PhotoInfo: Codable {
    let author: String
    let url: String
}

//class PhotoCell: UICollectionViewCell {
//    var imageView: UIImageView!
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        imageView = UIImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.contentMode = .scaleAspectFill
//        addSubview(imageView)
//        
//        NSLayoutConstraint.activate([
//            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//        ])
//    }
//    
//    required init?(coder: NSCoder) {
//        print("Error")
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//class MyViewController : UICollectionViewController {
//    var urls = [URL]()
//    
//    private func loaItems() {
//        guard let url = URL(string: "https://picsum.photos/v2/list?page=1&limit=200") else {
//            return
//        }
//        
//        guard let data = try? Data(contentsOf: url) else {
//            return
//        }
//        
//        let decoder = JSONDecoder()
//        
//        guard let loadedItems = try? decoder.decode([PhotoInfo].self, from: data) else {
//            return
//        }
//        
//        urls = loadedItems.compactMap { URL(string: $0.url) }
//    }
//    
//    private func initCollectionView() {
//        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "Cell")
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        loaItems()
//        initCollectionView()
//    }
//    
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? PhotoCell else {
//            fatalError("Can't dequeue PhotoCell")
//        }
//        
//        return cell
//    }
//    
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return urls.count
//    }
//}

// Present the view controller in the Live View window
//PlaygroundPage.current.liveView = MyViewController()
