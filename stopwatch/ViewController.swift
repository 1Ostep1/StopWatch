import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var newLapLabel: UILabel!
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var startBtn: UIButton!
    @IBOutlet var resetBtn: UIButton!
    
    var isPlaying:Bool = true
    var isStartPressed:Bool = true
    
    var minutes = 00
    var seconds = 0.0
    var time = ""
    var minutes2 = 00
    var seconds2 = 0.0
    var time2 = ""
    var lapCounter = 1
    var timer = Timer()
    var timer2 = Timer()

    private var dictOfSaved = [stopWatch]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName:"ResultTableViewCell", bundle: nil), forCellReuseIdentifier: "resultCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        startBtn.layer.cornerRadius = 0.2 * startBtn.bounds.size.width
        resetBtn.layer.cornerRadius = 0.2 * resetBtn.bounds.size.width
        startBtn.tintColor = .green
        resetBtn.tintColor = .black
        startBtn.backgroundColor = .white
        resetBtn.backgroundColor = .white
        
    }

    @IBAction func startAndStop(_ sender: UIButton) {
        if isStartPressed{
            startBtn.setTitle("Stop", for: .normal)
            startBtn.tintColor = .red
            resetBtn.setTitle("Lap", for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
            timer2 = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(UpdateTimer2), userInfo: nil, repeats: true)
            
            isPlaying = true
        }else{
            startBtn.setTitle("Start", for: .normal)
            startBtn.tintColor = .green
            resetBtn.setTitle("Reset", for: .normal)
            timer.invalidate()
            timer2.invalidate()
            isPlaying = false

        }
        isStartPressed = !isStartPressed
    }
    
    @IBAction func lapAndReset(_ sender: UIButton) {
        if isPlaying{
            let newItem = stopWatch(label: "Lap \(lapCounter)", time: "\(time)")
            dictOfSaved.append(newItem)
            tableView.reloadData()
            lapCounter += 1
            minutes2 = 0
            seconds2 = 0
            newLapLabel.text = "00:00.00"
        }else{
            resetBtn.setTitle("Lap", for: .normal)
            minutes = 0
            seconds = 0
            mainLabel.text = "00:00.00"
            timer.invalidate()
            dictOfSaved = []
            lapCounter = 1
            minutes2 = 0
            seconds2 = 0
            newLapLabel.text = "00:00.00"
            timer2.invalidate()
            tableView.reloadData()
            
        }
    }
    
    @objc func UpdateTimer2(){
        seconds2 = seconds2 + 0.01
        minutes2 += seconds2 > 60 ? 1 : 0
        seconds2 = seconds2 > 60 ? 0 : seconds2
        if seconds2 < 10{
            time2 = String(format: "%.02d %@", minutes2,":") + "0" + String(format: "%.2f", seconds2)
        }else{
            time2 = String(format: "%.02d %@ %.2f", minutes2,":",seconds2)
        }
        newLapLabel.text = time2
    }
 
    @objc func UpdateTimer(){
        seconds = seconds + 0.01
        minutes += seconds > 60 ? 1 : 0
        seconds = seconds > 60 ? 0 : seconds
        if seconds < 10{
            time = String(format: "%.02d %@", minutes,":") + "0" + String(format: "%.2f", seconds)
        }else{
            time = String(format: "%.02d %@ %.2f", minutes,":",seconds)
        }
       
        mainLabel.text = time
    }
    
}
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dictOfSaved.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell",for: indexPath) as! ResultTableViewCell
        let saved = dictOfSaved[indexPath.row]
        cell.setUpCell(with: saved)
        return cell
    }
    
}
