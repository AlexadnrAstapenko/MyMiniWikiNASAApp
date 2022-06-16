//
//  InfoVC.swift
//  NASAWiKi
//
//  Created by Александр Астапенко on 28.05.22.
//

import UIKit
import Alamofire
import AlamofireImage

final class InfoVC: UIViewController {

    var photo: PhotoOfDay?
    
    
    @IBOutlet weak var titleNavBar: UINavigationItem!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var infoText: UITextView!
    @IBOutlet var titleLbl: UILabel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestureSelector()
        setupData()
    }

    @IBAction func backBtn(_ sender: UIBarButtonItem) {
        selectVC(vc: ChangeDayVC(), storyboard: .photo)
    }
    func setupData() {
        titleNavBar.title = photo?.date
        infoText.text = photo?.explanation
        titleLbl.text = photo?.title
        Requsts.getPhoto(activityIndicator, photo?.hdurl, imageView)

    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let photoURL = photo?.hdurl,
           let desination = segue.destination as? FullScreenVC {
            desination.photoURLs = photoURL
            desination.navigationController?.title = photo?.title
        }
    }
    
    @objc func handleTapGesture(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: imageView)
        if imageView.frame.contains(location) == true {
            self.performSegue(withIdentifier: "goToFull", sender: sender)

        } else {
            print("error")
        }
    }
    private func setupGestureSelector() {
        let selector = #selector(handleTapGesture(_:))
        let tapGesture = UITapGestureRecognizer(target: self, action: selector)
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
    }
}
