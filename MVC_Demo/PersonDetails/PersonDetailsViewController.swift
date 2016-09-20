import UIKit

class PersonDetailsViewController : UIViewController {
    var personID: Int?
    var peopleService: PeopleServiceType = PeopleService()

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!

    override func viewDidLoad() {
        blankLabels()
        if let id = personID {
            peopleService.getPersonByID(withID: id) { [weak self] person in
                self?.updateLabels(withPerson: person)
            }
        }
    }

    internal func blankLabels() {
        for case let label as UILabel in stackView.subviews {
            label.text = ""
        }
    }

    private func updateLabels(withPerson person: Person) {
        nameLabel.text = "Name: \(person.name)"
        if let age = person.age {
            ageLabel.text = "Age: \(age)"
        }
        if let phone = person.phone {
            phoneLabel.text = "Phone: \(phone)"
        }
    }
}