//
//  Requsts.swift
//  NASAWiKi
//
//  Created by Александр Астапенко on 29.05.22.
//

import Alamofire
import AlamofireImage
import Foundation
import NVActivityIndicatorView
import NVActivityIndicatorViewExtended
import UIKit

class Requsts: UIViewController {
    // MARK: Get PhotoOfDay

    static func fetchData(with tableview: UITableView, _ startDate: String, _ endDate: String,
                          completion: @escaping () -> Void) {
        let urlPath = ApiConstant.photoOfDay + "&start_date=\(startDate)" + "&end_date=\(endDate)"
        // &start_date=2022-05-01&end_date=2022-05-10
        guard let url = URL(string: urlPath) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error { print(error) }
            guard let data = data else { return }
            do {
                ChangeDayVC.photo = try JSONDecoder().decode([PhotoOfDay].self, from: data)
            } catch {
                print(error)
            }
            DispatchQueue.main.async {
                tableview.reloadData()
                completion()
            }
        }
        task.resume()
    }

    // MARK: Get image on PhotoOfDay

    static func getPhoto(_ activityIndicator: UIActivityIndicatorView, _ photoURL: String?, _ imageView: UIImageView) {
        activityIndicator.startAnimating()
        if let photoURL = photoURL {
            if let image = CacheManager.shared.imageCache.image(withIdentifier: photoURL) {
                imageView.image = image
            } else {
                AF.request(photoURL).responseImage { response in
                    if case let .success(image) = response.result {
                        activityIndicator.stopAnimating()
                        imageView.image = image
                        CacheManager.shared.imageCache.add(image, withIdentifier: photoURL)
                    }
                }
            }
        }
    }
}
