//
//  domainTests.swift
//  domainTests
//
//  Created by Nihad Ismayilov on 03.10.22.
//

import XCTest
import Promises
import RxSwift
@testable import domain

final class UseCaseTests: XCTestCase {
    
    var mockData1: PopularNewsRepoMockData?
    var mockData2: CatogorizedNewsRepoMockData?
    var mockData3: SearchedNewsRepoMockData?
    
    let expectedData1 = PopularNews.init(results: [PopularNews.PopularResults.init(url: "", id: 0, updateDate: "", category: "", title: "", abstract: "", keywords: [""], media: [PopularNews.PopularResults.Media.init(mediaMetaData: [PopularNews.PopularResults.Media.MetaData.init(url: "")])], byline: "")])
    
    let expectedData2 = CategorizedNews.init(results: [CategorizedNews.Results.init(category: "", subCategory: "", title: "", abstract: "", url: "", byline: "", updatedDate: "", createdDate: "", publishedDate: "", multimedia: [CategorizedNews.Results.Multimedia.init(url: "")], keywords: [""])])
    
    let expectedData3 = SearchNews.init(response: SearchNews.Response.init(docs: [SearchNews.Response.Doc.init(abstract: "", webURL: "", multimedia: [SearchNews.Response.Doc.Multimedia.init(url: "")], headline: SearchNews.Response.Doc.Headline.init(main: "", printHeadline: ""), keywords: [SearchNews.Response.Doc.Keyword.init(keyword: "")], pubDate: "", category: "", subCategory: "", byline: SearchNews.Response.Doc.Byline.init(original: ""), id: "")]))

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockData1 = PopularNewsRepoMockData()
        mockData2 = CatogorizedNewsRepoMockData()
        mockData3 = SearchedNewsRepoMockData()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        mockData1 = nil
        mockData2 = nil
        mockData3 = nil
        try super.tearDownWithError()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetClassificationEventsUseCase1() {
        let useCase1 = GetPopularNewsUseCase(repo: mockData1!)
        
        let inputData = "TestId"
        var returnedData1: PopularNews?
        
        mockData1?.getPopularNewss.fulfill(expectedData1)
        
        let promise = XCTestExpectation(description: "Should return a value")
        
        useCase1.execute().then { popularNews in
            returnedData1 = popularNews
            promise.fulfill()
        }.catch { err in
            XCTFail(err.localizedDescription)
        }
        
        wait(for: [promise], timeout: 2.0)
        
        XCTAssertNotNil(returnedData1)
        XCTAssertEqual(expectedData1, returnedData1)
    }
    
    func testGetClassificationEventsUseCase2() {
        let useCase2 = GetGategorizedNewsUseCase(repo: mockData2!)
        
        let inputData = "TestId"
        var returnedData2: CategorizedNews?
        
        mockData2?.getCategorizedNewss.fulfill(expectedData2)
        
        let promise = XCTestExpectation(description: "Should return a value")
        
        useCase2.execute(with: "us").then { categorizedNews in
            returnedData2 = categorizedNews
            promise.fulfill()
        }.catch { err in
            XCTFail(err.localizedDescription)
        }
        
        wait(for: [promise], timeout: 2.0)
        
        XCTAssertNotNil(returnedData2)
        XCTAssertEqual(expectedData2, returnedData2)
    }
    
    func testGetClassificationEventsUseCase3() {
        let useCase3 = GetSearchNewsUseCase(repo: mockData3!)
        
        let inputData = "TestId"
        var returnedData3: SearchNews?
        
        mockData3?.getSearchedNewss.fulfill(expectedData3)
        
        let promise = XCTestExpectation(description: "Should return a value")
        
        useCase3.execute(with: "usa").then { searchedNews in
            returnedData3 = searchedNews
            promise.fulfill()
        }.catch { err in
            XCTFail(err.localizedDescription)
        }
        
        wait(for: [promise], timeout: 2.0)
        
        XCTAssertNotNil(returnedData3)
        XCTAssertEqual(expectedData3, returnedData3)
    }
    
}
