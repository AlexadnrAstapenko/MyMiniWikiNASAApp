//
//  CategoryTVC.swift
//  NASAWiKi
//
//  Created by Александр Астапенко on 27.05.22.
//

import Alamofire
import UIKit
import NVActivityIndicatorView
import NVActivityIndicatorViewExtended


// MARK: - ChangeDayVC

class ChangeDayVC: UIViewController, NVActivityIndicatorViewable {
    
    static var photo: [PhotoOfDay] = []

    @IBOutlet var startDay: UILabel!
    @IBOutlet var endDay: UILabel!
    @IBOutlet var startDayTF: UITextField!
    @IBOutlet var endDayTF: UITextField!
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        startDayTF.setInputViewDatePicker(target: self, selector: #selector(tapDone))
        endDayTF.setInputViewDatePicker(target: self, selector: #selector(tapDoneTwo))
    }
    

    @IBAction func searchInfoBtn(_: UIButton) {
        // date format start_date=2022-05-01  end_date=2022-05-10
        setUpAnimation()
        guard let startDay = startDayTF.text else { return }
        guard let endDay = endDayTF.text else { return }
        Requsts.fetchData(with: tableView, startDay, endDay) { [weak self]  in
            self?.stopAnimating()
        }
    }

    @objc func tapDone() {
        if let datePicker = startDayTF.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .medium
            dateformatter.dateFormat = "YYYY-MM-dd"
            startDayTF.text = dateformatter.string(from: datePicker.date)
        }
        self.startDayTF.resignFirstResponder()
    }

    @objc func tapDoneTwo() {
        if let datePicker = endDayTF.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .medium
            dateformatter.dateFormat = "YYYY-MM-dd"
            endDayTF.text = dateformatter.string(from: datePicker.date)
        }
        self.endDayTF.resignFirstResponder()
    }
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        self.selectVC(vc: ShowCategoryTVC(), storyboard: .main)
    }
    
    private func setUpAnimation() {
        startAnimating(
            CGSize(width: 40, height: 40),
            message: "Please wait..",
            type: .ballClipRotateMultiple,
            color: .black
        )
    }
    
}

// MARK: UITableViewDelegate, UITableViewDataSource

extension ChangeDayVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return ChangeDayVC.photo.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "\(ChangeDayVC.photo[indexPath.row].date ?? ""):\n" + "\(ChangeDayVC.photo[indexPath.row].title ?? "")"
        return cell
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        let date = ChangeDayVC.photo[indexPath.row]
        performSegue(withIdentifier: "GoInfo", sender: date)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let desination = segue.destination as? InfoVC,
           let photo = sender as? PhotoOfDay
        {
            desination.photo = photo
        }
    }
}
