//
//  chocoswift1Tests.swift
//  chocoswift1Tests
//
//  Created by kazushi.hara on 2016/02/13.
//  Copyright © 2016年 haranicle. All rights reserved.
//

import XCTest
@testable import chocoswift1

protocol Greetable {
    func hello() -> String
}



class chocoswift1Tests: XCTestCase {
    
    func test_isとisKindOfClassの挙動について() {
        
        class PersonClass: NSObject, Greetable{
            func hello() -> String {
                return "こんにちは"
            }
        }
        
        class HaraClass: PersonClass {
            override func hello() -> String {
                return "こんにちは！！"
            }
            
            //    func hadoken() -> String {
            //        return "波動拳"
            //    }
        }
        
        let hara = HaraClass()
        XCTAssertTrue(hara is PersonClass)
        XCTAssertTrue(hara is HaraClass)
        XCTAssertTrue(hara is Greetable)
        XCTAssertTrue(hara.isKindOfClass(PersonClass))
        XCTAssertTrue(hara.isKindOfClass(HaraClass))
        
        let person = PersonClass()
        XCTAssertTrue(person is PersonClass)
        XCTAssertTrue(person is HaraClass) // 🙅Fail
        XCTAssertTrue(person is Greetable)
        XCTAssertTrue(person.isKindOfClass(PersonClass))
        XCTAssertTrue(person.isKindOfClass(HaraClass)) // 🙅Fail
        
        let anyHara = HaraClass() as AnyObject
        XCTAssertTrue(anyHara is PersonClass)
        XCTAssertTrue(anyHara is HaraClass)
        XCTAssertTrue(anyHara is Greetable)
        XCTAssertTrue(anyHara.isKindOfClass(PersonClass))
        XCTAssertTrue(anyHara.isKindOfClass(HaraClass))
        
        let anyPerson = PersonClass() as AnyObject
        XCTAssertTrue(anyPerson is PersonClass)
        XCTAssertTrue(anyPerson is HaraClass) // 🙅Fail
        XCTAssertTrue(anyPerson is Greetable)
        XCTAssertTrue(anyPerson.isKindOfClass(PersonClass))
        XCTAssertTrue(anyPerson.isKindOfClass(HaraClass)) // 🙅Fail
    }
    
    func test_mutatingについて () {
        
        struct MyStruct {
            var name:String
            mutating func changeMe() {
                name = "changed name"
            }
        }
        
        // ↓ここvarにしないといけないのは最高
        var myStruct = MyStruct(name: "hara")
        myStruct.changeMe()
        XCTAssert(myStruct.name == "changed name")
        
        enum MyEnum {
            case Yes, No
            mutating func changeMe() {
                switch self {
                case .Yes:
                    self = .No
                case .No:
                    self = .Yes
                }
            }
        }
        
        var reply = MyEnum.No
        reply.changeMe()
        XCTAssert(reply == .Yes)

        class MyClass {
            var name = ""
            // なんでClassはmutatingできないの
//            mutating func changeMe() { // mutating isn't valid on methods in classes or class-bound protocols
//                self = MyClass()
//            }
        }
        
    }
    
   
}
