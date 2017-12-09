class Task {
    var id: Int
    var title: String
    var description: String
    var priority: Int
    var createdAt: String
    var updatedAt: String
    
    init(id: Int, title: String, description: String, priority: Int, createdAt: String, updatedAt: String) {
        self.id = id
        self.title = title
        self.description = description
        self.priority = priority
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
