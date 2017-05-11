import StORM
import SQLite
import SQLiteStORM

class Book: SQLiteStORM {
  var id: Int = 0
  var title: String = ""
  var name: String = ""

  override open func table() -> String {
    return "books"
  }

  override func to(_ this: StORMRow) {
    id = this.data["id"] as? Int ?? 0
    title = this.data["title"] as? String ?? ""
    name = this.data["name"] as? String ?? ""
  }

  func rows() -> [Book] {
    var rows = [Book]()
    for i in 0..<self.results.rows.count {
      let row = Book()
      row.to(self.results.rows[i])
      rows.append(row)
    }
    return rows
  }

  func asDictionary() -> [String: Any] {
    return [
      "id": self.id,
      "title": self.title,
      "name": self.name
    ]
  }
}
