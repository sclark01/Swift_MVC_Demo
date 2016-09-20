import Foundation
import Quick
import Nimble
import OHHTTPStubs
import SwiftyJSON

@testable import MVC_Demo

class PeopleServiceTests: QuickSpec {
    override func spec() {
        beforeEach {
            stub(isHost("localhost") && isPath("/list") && isMethodGET()) { request in

                let obj = [[
                    "id": 7,
                    "name": "Ballard Craig",
                ],
                [
                    "id": 8,
                    "name": "Brown Holt",
                ]]

                return OHHTTPStubsResponse(JSONObject: obj, statusCode: 200, headers: nil).responseTime(OHHTTPStubsDownloadSpeed3G)
            }

            stub(isHost("localhost") && isPath("/personByID") && isMethodGET()) { request in
                let obj = [[
                    "id": 9,
                    "name": "Harry Potter",
                    "age": 11,
                    "phone": "wand"
                ]]

                return OHHTTPStubsResponse(JSONObject: obj, statusCode: 200, headers: nil).responseTime(OHHTTPStubsDownloadSpeed3G)
            }

            stub(isHost("localhost") && isPath("/listAll") && isMethodGET()) { request in

                let obj = [[
                    "id": 7,
                    "name": "Ballard Craig",
                    "age": 19,
                    "phone": "somePhone"
                    ],
                    [
                        "id": 8,
                        "name": "Brown Holt",
                        "age": 10,
                        "phone" : "somePhone"
                    ]]

                return OHHTTPStubsResponse(JSONObject: obj, statusCode: 200, headers: nil).responseTime(OHHTTPStubsDownloadSpeed3G)
                
            }
        }

        afterEach {
            OHHTTPStubs.removeAllStubs()
        }

        describe(".getAllPeople") {
            it("should get people with limited detail from list endpoint") {
                let peopleService = PeopleService()
                var completionCalled = false
                var actualPeople:[Person] = []

                peopleService.getAllPeople { people in
                    completionCalled = true
                    actualPeople = people
                }

                expect(completionCalled).toEventually(beTrue())
                expect(actualPeople).toEventually(haveCount(2))

                let firstPerson = actualPeople.first

                expect(firstPerson?.id).toNot(beNil())
                expect(firstPerson?.name).toNot(beNil())
                expect(firstPerson?.phone).to(beNil())
            }
        }
        
        describe(".getAllPeopleWithDetails"){
            it("should get people with details from listAll endpoint") {
                let peopleService = PeopleService()
                var completionCalled = false
                var actualPeople:[Person] = []

                peopleService.getAllPeopleWithDetails { people in
                    completionCalled = true
                    actualPeople = people
                }

                expect(completionCalled).toEventually(beTrue())
                expect(actualPeople).toEventually(haveCount(2))

                 let firstPerson = actualPeople.first
                expect(firstPerson?.phone).toNot(beNil())

            }
        }

        describe("get person by ID") {
            it("should get a person based on ID") {
                let peopleService = PeopleService()
                var completionCalled = false
                var actualPerson: Person!

                peopleService.getPersonByID(withID: 9) { person in
                    completionCalled = true
                    actualPerson = person
                }
                expect(completionCalled).toEventually(beTrue())
                expect(actualPerson).toEventually(equal(Person(id: 9, name: "Harry Potter", age: 11, phone: "wand")))
            }
        }
    }
}