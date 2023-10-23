import Foundation

var width: Float = 3.4
var height: Float = 2.1

var bucketsOfPaint: Int {
  get {
    let area = width * height
    let areaCoveredPerBucket: Float = 1.5
    let numberOfBuckets = area / areaCoveredPerBucket
    let roundedBuckets = ceilf(numberOfBuckets)
    return Int(roundedBuckets)
  }
  set {
    let areaCoveredPerBucket: Float = 1.5
    let area = areaCoveredPerBucket * Float(newValue)
    print("\(newValue) amount of bucket can paint \(area) ")
  }
}

print(bucketsOfPaint)

bucketsOfPaint = 12






//var pizzaInInches: Int = 10 {
//  willSet {
//    
//  }
//  didSet {
//    if pizzaInInches >= 18 {
//      print("Invalid size specified, pizzaInhes set to 18.")
//      pizzaInInches = 18
//    }
//  }
//}
//pizzaInInches = 45
//
//var numberOfPeople: Int = 12
//let slicesPerPerson: Int = 4
//
//var numberOfSlices: Int {
//  get {
//    return pizzaInInches - 4
//  }
//}
//
//var numberOfPizza: Int {
//  get {
//    let numberOfPeopleFedPerPizza = numberOfSlices / slicesPerPerson
//    return numberOfPeople / numberOfPeopleFedPerPizza
//  }
//  set {
//    let totalSlices = numberOfSlices * newValue
//    numberOfPeople = totalSlices / slicesPerPerson
//  }
//}
//
//
//numberOfPizza = 4

