//
//  ViewController.swift
//  SampleTesting
//
//  Created by Nayome Devapriya on 27/11/17.
//  Copyright © 2017 Nayome Devapriya. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let path = Bundle.main.path(forResource: "Java/MetaCleanCL/MetaCleanCL", ofType: "jar") {
            NSLog("%@", "jar path : \(path)")
            
            let task = Process()
            task.launchPath = "/usr/bin/java"
            let filePath = "/Users/nayome.devapriya/Documents/TestData"
            
            let arg = String.init(format: "-f %@/file.pdf -metadata custom", filePath)
            var argumentsArray = [String]()
            argumentsArray.append(contentsOf: ["-jar", path])
            argumentsArray.append(contentsOf: arg.components(separatedBy: " "))
            task.arguments = argumentsArray

            let pipe = Pipe()
            task.standardOutput = pipe
            let errorPipe = Pipe()
            task.standardError = errorPipe
            task.launch()
            task.waitUntilExit()
            
            NSLog("%@", "Task is finished")
            
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            let output: String = NSString(data: data, encoding: String.Encoding.utf8.rawValue)! as String
            
            let errorData = pipe.fileHandleForReading.readDataToEndOfFile()
            let errorOutput: String = NSString(data: errorData, encoding: String.Encoding.utf8.rawValue)! as String
            
            NSLog("%@", output)
            NSLog("%@", errorOutput)

        }
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

