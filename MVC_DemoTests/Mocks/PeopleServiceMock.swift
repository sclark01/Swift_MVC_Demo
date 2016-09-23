import Foundation

@testable import MVC_Demo

class PeopleServiceMock: PeopleServiceType {
    var getAllPeopleCalled = false
    var getPersonByIDCalled = false
    var didCallPersonByIDWithID: Int?
    var getAllPeopleWithDetailsCalled = false
    var stubbedPeople = [Person(id: 1, name: "someName", age: 15, phone: "somePhone")]
    var stubbedPerson = Person(id: 0, name: "someName", age: 10, phone: "somePhone")

    func getAllPeople(_ onCompletion: @escaping ([Person]) -> Void){
        getAllPeopleCalled = true
        onCompletion(stubbedPeople)
    }

    func getPersonByID(withID id: Int, onCompletion: @escaping (Person) -> Void) {
        getPersonByIDCalled = true
        didCallPersonByIDWithID = id
        onCompletion(stubbedPerson)
    }
    
    func getAllPeopleWithDetails(_ onCompletion: @escaping ([Person])-> Void) {
        getAllPeopleWithDetailsCalled = true
        onCompletion(stubbedPeople)
    }
}
