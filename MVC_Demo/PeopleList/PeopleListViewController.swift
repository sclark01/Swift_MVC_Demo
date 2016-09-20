import UIKit

class PeopleListViewController : UIViewController {
    var people: [Person]?
    var peopleService: PeopleServiceType = PeopleService()

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        getPeople()
    }

    private func getPeople() {
        peopleService.getAllPeopleWithDetails { [weak self] people in
            self?.people = people
            self?.tableView.reloadData()
        }
    }

    internal func transitionToDetailsViewForPersonWith(id id: Int) {
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
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people?.count ?? 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "personCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) ?? UITableViewCell(style: .Subtitle, reuseIdentifier: cellIdentifier)

        if let people = people {
            let person = people[indexPath.row]
            cell.textLabel?.text = person.name
            cell.detailTextLabel?.text = "Phone: \(person.phone ?? "")"
        }

        return cell
    }
}

extension PeopleListViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        guard let people = people else { return }
        transitionToDetailsViewForPersonWith(id: people[indexPath.row].id)
    }
}
