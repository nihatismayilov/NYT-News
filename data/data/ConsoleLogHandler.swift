//
//  ConsoleLogHandler.swift
//  data
//
//  Created by Nihad Ismayilov on 02.09.22.
//

import Foundation

class ConsoleLogHandler: LogHandler {
    
    func log(_ message: String) {
        #if DEBUG
        print(message)
        #endif
    }
}
