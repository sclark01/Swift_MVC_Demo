import Foundation

struct Person {
    let id: Int
    let name: String
    let age: Int?
    let phone: String?

    init(id:Int, name: String, age: Int? = nil, phone: String? = nil){
        self.id = id
        self.name = name
        self.age = age
        self.phone = phone
    }
}

extension Person : Equatable {}

func ==(lhs: Person, rhs: Person) -> Bool {
    return lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.age == rhs.age &&
        lhs.phone == rhs.phone
}