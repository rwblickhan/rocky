alias l := lint

lint:
    swiftformat . && swiftlint
