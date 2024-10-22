import SwiftUI

struct Person {
    let fullName: String
    enum Category {
        case unspecified
        // swiftlint:disable:next nesting
        struct Profile {
            let age: Int
        }
    }
}

class ActionController {
    var completionHandler: (() -> Void)?
    let primaryNumbers = [1, 2, 34, 5, 7, 8]
    let details = ["name": "Mostafa", "age": "25"]
    var secondaryNumbers = [1, 2, 3, 5, 6, 7] {
        willSet {
            debugPrint("Numbers list will be updated")
        }
        didSet {
            debugPrint("Numbers list updated")
        }
    }

    var name: String {
        "Mostafa"
    }

    let personInfo = (name: "Mostafa", age: 25, attributes: ((0, 0), (10, 20)))

    func performAction(with _: () -> Void) {
        func logAction() {
            debugPrint("Action logged")
        }

        _ = Person(fullName: "Mostafa")
        _ = Person.Category.Profile(age: 25)
    }

    func handleCallback() {
        let errorState = Person.Category.unspecified

        switch errorState {
        case .unspecified:
            debugPrint("Unspecified category")
        }

        performAction { print("Action block executed") }
    }

    struct ContentView: SwiftUI.View {
        // swiftlint:disable:next nesting
        enum ViewConstants {
            case fullName
            case ageInfo
        }

        func handleAppear() {
            print("View appeared")
        }

        func onItemTapped() -> Bool {
            return true
        }

        var body: some View {
            VStack {
                HStack {
                    VStack {
                        ScrollView {
                            Text("Hello, World!")
                        }
                    }
                }
            }
        }
    }
}
