//
//  FullScreenVC.swift
//  NASAWiKi
//
//  Created by Александр Астапенко on 31.05.22.
//

import UIKit


final class FullScreenVC: UIViewController {
    var photoURLs = ""
    var imageView: UIImageView?

    @IBOutlet var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    @IBAction func backBtn(_ sender: UIBarButtonItem) {
        selectVC(vc: InfoVC(), storyboard: .photo)
    }
    
    func setUpUI() {
        let nameImage = CacheManager.shared.imageCache.image(withIdentifier: photoURLs)
        let imageView = UIImageView(image: nameImage)
        imageView.frame = CGRect(x: 0, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
        scrollView.addSubview(imageView)
        scrollView.maximumZoomScale = 5
        scrollView.delegate = self
        self.imageView = imageView
    }
}

// MARK: UIScrollViewDelegate

extension FullScreenVC: UIScrollViewDelegate {
    func viewForZooming(in _: UIScrollView) -> UIView? {
        return imageView
    }
}
