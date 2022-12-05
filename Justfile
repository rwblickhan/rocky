brew:
    brew install mint

mint: brew
    mint bootstrap

lint:
    mint run swiftformat . && mint run swiftlint
