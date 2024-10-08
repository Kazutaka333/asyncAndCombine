//
//  main.swift
//  asyncAndCombine
//
//  Created by Kazutaka Homma on 2024-10-07.
//
// reference: https://forums.swift.org/t/how-to-mix-async-await-and-combine/49394

import Combine
import Foundation

let subject = PassthroughSubject<Int, Never>()

func handle(_ i: Int) async {
    print("handling: \(i)")
    if i >= 100 {
        exit(0)
    }
}

let sub = subject.sink { i in
//    print("subject1 : \(i)")
    // this task is not guaranteed to be executed in order
    Task {
        await handle(i)
    }
}


for i in 0...100 {
    subject.send(i)
}

RunLoop.main.run()
