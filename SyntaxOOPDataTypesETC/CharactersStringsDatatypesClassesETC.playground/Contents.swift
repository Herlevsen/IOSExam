//: Playground - noun: a place where people can play

import UIKit

///////////////////// Data types /////////////////////

// MARK: Characters
let char1: Character    = "A"
let char2: Character    = "B"
let charArray           = [char1, char2]

// String from character array
let charString          = String(charArray)

// Character array from string
let charArray2          = Array(charString.characters)

var str1 = "Hello playground"
var str2 = "Hello world"

// String interpolation
let str3 = "\(str1), \(str2)"

//  Floats and doubles - Double is default
let double = 3.14
let float: Float = 3.14

// Prove double is default
double is Double
double is Float
float  is Float
float  is Double

// Boolean
var bool = true
bool = false

// Arrays
let strArray    = ["a", "b", "c", "d", "e", "f", "g"]
let doubleArray = [3.1, 2.9, 9.11]


///////////////////// Custom Operators /////////////////////


prefix operator +++ {}
prefix func +++(number: Int) -> Int {
    return number * 2
}

+++4
+++8


///////////////////// Loops /////////////////////

// Foreach
for str in strArray {
    print(str)
}

// For with range
for i in 0 ..< 10 {
    print(i)
}

// While
var i = 0
while i < 10 {
    print(i)
    i += 1
}

// Repeat while (do while)
i = 0
repeat {
    print(i)
    i += 1
} while i < 10



///////////////////// Variables, constants /////////////////////



// Variables constants

// Variable, mutatable
var j = 0
j = 2

// Constant immutable
let k = 0
// k = 2 - not possible, k is constant


///////////////////// Collections & Tuples /////////////////////

//// Array ////
var arr1 = ["Hello", "world"]
arr1.append("It's")
arr1.append("Me")
arr1.append("Joe")
arr1.removeLast()
print(arr1)

//// Dictionary ////
var nameAgeDict: [String : Int] = [:]
nameAgeDict["Joe"] = 10
nameAgeDict["John"] = 12

print(nameAgeDict["Joe"])

//// Tuples ////

// Unnamed tuple
let nameAndAge = ("John", 15)
// let tipAndTotal:(Double, Double) = (4.00, 25.19) - Explicit type
nameAndAge.0
nameAndAge.1
let (name, age) = nameAndAge
name
age

// Named tuple
let nameAndAge2 = (name:"Jack", age:17)
nameAndAge2.name
nameAndAge2.age

///////////////////// Closures /////////////////////
// Anonymous function, ie. a function without a name
// Local scope

func speakTo(firstName: String, lastName: String, completion: () -> ()) {
    print("Hello " + firstName + " " + lastName)
    completion()
}

// Would print:
// Hello John Doe
// Hello from the closure side
// Because closure is last parameter, we can put it as a code block at the end
speakTo("John", lastName: "Doe") {
    print("Hello from the closure side")
}

// Here closure is not the last parameter
func doSomething(before: (message: String) -> (), name: String) {
    print("This is going to look strange")
}

doSomething({ (message) in
    print("Hello")
    }, name: "John Doe")


///////////////////// Optionals /////////////////////

var value = "I have a value"
var optionalValue: String? = "I have a value but i can be nil"
optionalValue = nil
// value = nil - Not possible, can't be nil

// if let
optionalValue = "Hello there"
if let val = optionalValue {
    print("Optional has a value: \(val)")
}

// Guard
func messageIfNotNil(message: String?) {
    guard message != nil else {
        print("Optional does not have a value")
        return
    }
    
    print(message)
}

messageIfNotNil(optionalValue)
messageIfNotNil(optionalValue) // (2 times)
optionalValue = nil
messageIfNotNil(optionalValue)


///////////////////// Classes, Structs, Protocol /////////////////////

protocol Greet {
    func greet(person: Person)
    func greet()
}

class Person: Greet {
    
    // Static variables/consts
    static let someStatic = "This is static"
    
    // Instance variables/consts
    let name: String
    let age: Int
    
    // Constructor / Initializer
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    // Implements methods from greet protocol
    func greet(person: Person) {
        print("Hello \(person.name), my name is \(self.name)")
    }
    
    func greet() {
        print("Hello, nice to meet you")
    }
}

class Robot: Greet {

    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    func greet(person: Person) {
        print("Hello \(person.name), my name is \(self.name)")
    }
    
    func greet() {
        print("Hello, nice to meet you")
    }
}

let person1 = Person(name: "John", age: 30)
let person2 = Person(name: "Jack", age: 31)

person1.greet(person2)
person2.greet()

let robot = Robot(name: "R2D2")
robot.greet(person1)
robot.greet(person2)

// 2 person and a robot in same list, because they share the protocol Greet
let greeters: [Greet] = [person1, person2, robot]

for greeter in greeters {
    print(greeter.greet())
}

struct Coordinate {
    
    var latitude: Double
    var longitude: Double
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

// Structs are pass by value instead of reference, meaning the values are copied:
var coord = Coordinate(latitude: 1, longitude: 2)
var coord2 = coord

print(coord2.latitude)
coord2.latitude = 0
print(coord2.latitude)
print(coord.latitude) // Coord 1 latitude is still 1


///////////////////// Generics /////////////////////


// Function

func swapTwoValues<T>(inout a: T, inout b: T) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var a = 1
var b = 2

swapTwoValues(&a, b: &b)

print(a)
print(b)

// Class

class Stack<T> {
    
    var arr: [T] = []
    
    func push(val: T) {
        arr.append(val)
    }
    
    func pop() -> T? {
        let val = arr.last
        arr.removeLast()
        
        return val
    }
    
}

var personStack = Stack<Person>()
personStack.push(person1)
personStack.push(person2)
let popped = personStack.pop()
