//
//  ViewController.swift
//  fetchApiWithAlamofire
//
//  Created by mac on 2021/5/3.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var animal: [Animal] = []
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        let url = "https://data.coa.gov.tw/Service/OpenData/TransService.aspx?UnitId=QcbUEzN6E6DL&$top=1000&$skip=0"
        
        AF.request(url).responseDecodable(of: [Animal].self) { animalData in
            if animalData.value != nil {
                self.animal = animalData.value!
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animal.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MyCell
        let data = animal[indexPath.row]
        if let imageUrl = URL(string: data.album_file) {
            if let image = NSData(contentsOf: imageUrl) {
                cell.album.image = UIImage(data: image as Data)
            }
        }
        cell.id.text = String(data.animal_id)
        cell.age.text = data.animal_age
        cell.place.text = data.animal_place
        cell.address.text = data.shelter_address
        cell.tel.text = data.shelter_tel
        cell.remark.text = data.animal_remark
        return cell
    }
        
}
    
struct Animal:Decodable {
    var animal_id: Int
    var animal_age: String
    var animal_place: String
    var animal_remark: String
    var album_file: String
    var shelter_address: String
    var shelter_tel: String
}
