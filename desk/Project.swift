class Project {
    var id: Int
    var title: String
    var description: String
    var createdAt: String
    var updatedAt: String
    
    init(id: Int, title: String, description: String, createdAt: String, updatedAt: String) {
        self.id = id
        self.title = title
        self.description = description
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
