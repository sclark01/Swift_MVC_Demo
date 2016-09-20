import UIKit
import Quick
import Nimble

@testable import MVC_Demo

class PersonDetailsViewControllerTests : QuickSpec {
    override func spec() {
        var viewController: PersonDetailsViewController!
        var serviceMock: PeopleServiceMock!
        let id = 10

        beforeEach {
            let storyBoard = UIStoryboard(name: "PersonDetails", bundle: nil)
            viewController = storyBoard.instantiateInitialViewController() as! PersonDetailsViewController
            serviceMock = PeopleServiceMock()
            viewController.personID = id
            viewController.peopleService = serviceMock
            let _ = viewController.view
        }

        describe("person details view controller") {
            it("should get people from people service on view did load") {
                viewController.personID = id

                expect(serviceMock.didCallPersonByIDWithID) == id 
            }

            it("should set the labels to the empty string") {
                let label = UILabel()
                label.text = "someText"
                viewController.stackView.addSubview(label)

                viewController.blankLabels()

                for case let label as UILabel in viewController.stackView.subviews {
                    expect(label.text) == ""
                }
            }

            it("should set the labels to their proper values when a person is returned") {
                let person = serviceMock.stubbedPerson

                let expectedName = "Name: \(person.name)"
                let expectedAge = "Age: \(person.age!)"
                let expectedPhone = "Phone: \(person.phone!)"

                expect(viewController.nameLabel.text).toEventually(equal(expectedName))
                expect(viewController.ageLabel.text).toEventually(equal(expectedAge))
                expect(viewController.phoneLabel.text).toEventually(equal(expectedPhone))
            }
        }
    }
}