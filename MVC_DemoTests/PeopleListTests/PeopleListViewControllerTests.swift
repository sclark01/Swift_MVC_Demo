import Foundation
import Quick
import Nimble

@testable import MVC_Demo

class PeopleListViewControllerTests : QuickSpec {
    override func spec() {
        var viewController: PeopleListViewController!
        var serviceMock: PeopleServiceMock!

        beforeEach {
            let storyBoard = UIStoryboard(name: "PeopleList", bundle: nil)
            viewController = storyBoard.instantiateInitialViewController() as! PeopleListViewController
            serviceMock = PeopleServiceMock()
            viewController.peopleService = serviceMock
            let _ = viewController.view
        }

        describe("the people list view controller") {
            it("should get all people from services") {
                expect(serviceMock.getAllPeopleWithDetailsCalled).to(beTrue())
            }

            it("should return the count of people for number of rows in section") {
                let rows = viewController.tableView(viewController.tableView, numberOfRowsInSection: 0)
                expect(rows).toEventually(equal(1))
            }

            it("should return the correct cell with label set") {
                let cell = viewController.tableView(viewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
                expect(cell.textLabel!.text).toEventually(equal("someName"))
                expect(cell.detailTextLabel!.text).toEventually(equal("Phone: somePhone"))
            }
        }

        describe("transitioning to details view") {
            it("should push the right view controller with the correctID set") {
                let testableViewController = TestablePeopleListViewController()
                let id = 10

                testableViewController.transitionToDetailsViewForPersonWith(id: id)

                expect(testableViewController.didTransitionToViewController).to(beAKindOf(PersonDetailsViewController.self))
                let pushedVC = testableViewController.didTransitionToViewController as! PersonDetailsViewController
                expect(pushedVC.personID) == id
            }
        }
    }
}

class TestablePeopleListViewController : PeopleListViewController {
    var didTransitionToViewController: UIViewController?
    override func transitionTo(viewController vc: UIViewController) {
        didTransitionToViewController = vc
    }
}
