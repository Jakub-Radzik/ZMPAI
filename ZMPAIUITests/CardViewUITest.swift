//
//  CardViewUITest.swift
//  ZMPAIUITests
//
//  Created by Kamil Herbetko on 11/10/2024.
//

import XCTest

final class CardViewUITests: XCTestCase {

    func testCardViewLayoutToggle() throws {
        let app = XCUIApplication()
        app.launchArguments = ["UITesting"]
        app.launch()
        
        // Navigate to rented books
        let myBooks = app.tabBars.buttons["Twoje książki"]
        XCTAssertTrue(myBooks.waitForExistence(timeout: 5), "My books tab should exist")
        myBooks.tap()
        
        // Assume the app launches with CardView in the initial view
        let twoColumnToggleIcon = app.buttons["square.split.1x2.fill"]
        let oneColumnToggleIcon = app.buttons["square.split.2x2.fill"]

        // Verify initial layout is 2-column layout by checking for the correct icon
        XCTAssertTrue(twoColumnToggleIcon.exists, "The app should start with a 2-column layout.")

        // Tap on the toggle to switch to 1-column layout
        twoColumnToggleIcon.tap()

        // Verify the icon has switched to the 2x2 grid icon (indicating 1-column layout is active)
        XCTAssertTrue(oneColumnToggleIcon.exists, "The 1-column layout should now be active.")

        // Tap the toggle to switch back to 2-column layout
        oneColumnToggleIcon.tap()

        // Verify the 2-column layout is restored
        XCTAssertTrue(twoColumnToggleIcon.exists, "The 2-column layout should be restored.")
    }
}
