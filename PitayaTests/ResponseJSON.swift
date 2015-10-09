//
//  ResponseJSON.swift
//  Pitaya
//
//  Created by 吕文翰 on 15/10/10.
//  Copyright © 2015年 http://lvwenhan.com. All rights reserved.
//

import XCTest
import Pitaya

class ResponseJSON: WithParams {
    
    func testResponseJSON() {
        let expectation = expectationWithDescription("testResponseJSON")
        
        Pita.build(HTTPMethod: .GET, url: "http://httpbin.org/get")
            .addParams([param1: param2, param2: param1])
            .onNetworkError({ (error) -> Void in
                XCTAssert(false, error.localizedDescription)
            })
            .responseJSON({ (json, response) -> Void in
                XCTAssert(json["args"][self.param1].stringValue == self.param2)
                XCTAssert(json["args"][self.param2].stringValue == self.param1)
                
                expectation.fulfill()
            })
        
        waitForExpectationsWithTimeout(self.defaultTimeout, handler: nil)
    }
}
