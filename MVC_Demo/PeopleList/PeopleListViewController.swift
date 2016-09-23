import UIKit

class PeopleListViewController : UIViewController {
    var people: [Person]?
    var peopleService: PeopleServiceType = PeopleService()

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        getPeople()
    }

    fileprivate func getPeople() {
        peopleService.getAllPeopleWithDetails { [weak self] people in
            self?.people = people
            self?.tableView.reloadData()
        }
    }

    internal func transitionToDetailsViewForPersonWith(id: Int) {
        let storyBoard = UIStoryboard(name: "PersonDetails", bundle: nil)
        guard let viewController = storyBoard.instantiateInitialViewController() as? PersonDetailsViewController else { return }
        viewController.personID = id
        transitionTo(viewController: viewController)
    }

    internal func transitionTo(viewController vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension PeopleListViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "personCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) ?? UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)

        if let people = people {
            let person = people[(indexPath as NSIndexPath).row]
            cell.textLabel?.text = person.name
            cell.detailTextLabel?.text = "Phone: \(person.phone ?? "")"
        }

        return cell
    }
}

extension PeopleListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let people = people else { return }
        transitionToDetailsViewForPersonWith(id: people[(indexPath as NSIndexPath).row].id)
    }
}
