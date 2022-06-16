//
//  ShowCategoryTVC.swift
//  NASAWiKi
//
//  Created by Александр Астапенко on 2.06.22.
//

import UIKit

class ShowCategoryTVC: UITableViewController {
    @IBOutlet var navBarItem: UINavigationBar!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return CategoryManager.Category.allCases.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = CategoryManager.Category.allCases[indexPath.row].rawValue
        return cell
    }

    @IBAction func backButton(_: UIBarButtonItem) {
        self.selectVC(vc: MainPageVC(), storyboard: .main)
    }

    // MARK: - Navigation

    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = CategoryManager.Category.allCases[indexPath.row]
        switch person {
        case .photoOfDay:
            self.selectVC(vc: ChangeDayVC(), storyboard: .photo)
        }
    }
}
