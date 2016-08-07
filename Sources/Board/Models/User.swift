import Vapor
import Mustache
import Fluent

public final class User: Model {
    public var id: Node?
    var name: String
    
    init(id: Node? = nil, name: String) {
        self.id = id
        self.name = name
    }
	
	public static func prepare(_ database: Database) throws {
		// TODO: Remove
	}
	
	public static func revert(_ database: Database) throws {
		// TODO: Remove
	}
}

// MARK: Node Conversions

extension User {
    public convenience init(node: Node, in context: Vapor.Context) throws {
        self.init(
            id: try node.extract("id"),
            name: try node.extract("name")
        )
    }

    public func makeNode() throws -> Node {
        return try Node(node: [
            "id": id,
            "name": name
        ])
    }
}

// MARK: Relations

extension User {
    func posts() -> Children<Post> {
        return children(Post.self)
    }
    
    func postCount() throws -> Int {
        return try children(Post.self).all().count // TODO: Make more efficient? Raw query?
    }
}
