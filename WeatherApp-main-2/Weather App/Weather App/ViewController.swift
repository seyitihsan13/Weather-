import UIKit

struct Group {
    let title : String
    let City : [String]
    let feels :[String]
}

final class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let City: [String: [String]] = [
        "A": ["Adana", "Adiyaman", "Afyonkarahisar", "Agri", "Amasya", "Ankara", "Antalya", " Artvin", "Aydin", "Ardahan","Aksaray"],
        "B": ["Balikesir", "Bilecik", "Bingöl", "Bitlis", "Bolu", "Burdur", "Bursa", "Bayburt", "Bartin", "Batman"],
        "C": ["Canakkale", "Cankiri", "Corum"],
        "D": ["Denizli", "Diyarbakir","Düzce"],
        "E": ["Edirne", "Elazig", "Erzincan", "Erzurum", "Eskisehir"],
        "G": ["Gaziantep", "Giresun", "Gumushane"],
        "H": ["Hakkari", "Hatay"],
        "I": ["Isparta", "Istanbul", "Izmır", "Igdır"],
        "M": ["Mersin","Malatya", "Manisa", "Mardin", "Mugla", "Mus"],
        "K": ["Kars", "Kastamonu", "Kayseri", "Kirklareli", "Kirsehir", "Kocaeli", "Konya", "Kütahya", "Kahramanmaras", "Karaman", "Kırıkkale","Kilis","Karabük"],
        "N": ["Nevsehir", "Nigde"],
        "O": ["Ordu", "Osmaniye"],
        "R": ["Rize"],
        "S": ["Sakarya", "Samsun", "Siirt", "Sinop", "Sivas", "Sanlıurfa","Sırnak"],
        "T": ["Tekirdag", "Trabzon", "Tokat", "Tunceli"],
        "U": ["Usak"],
        "V": ["Van"],
        "Y": ["Yozgat", "Yalova"],
        "Z": ["Zonguldak"],
        ]
    
    private let alphabet = "abcdefghijklmnoprstuvwxyz"
    
    private let tableView: UITableView = {
        let table  = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    var models = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpData()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setUpData() {
        for (key, value) in City {
            models.append(.init(title: key, City: value, feels: value))
        }
        models = models.sorted(by: { $0.title < $1.title })
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top,
            width: view.frame.size.width,
            height: view.frame.size.height-view.safeAreaInsets.top
        )
    }
    // TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].City.count
        return models[section].feels.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.section].City[indexPath.row]
        cell.textLabel?.text = models[indexPath.section].feels[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return models[section].title
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return models.compactMap({ $0.title })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "detailViewController") as! DetailViewController
        vc.city =  models[indexPath.section].City[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
