import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import StORM
import SQLiteStORM

SQLiteConnector.db = "./db/database.sqlite"

let db = Book()
try? db.setup()

let server = HTTPServer()
server.documentRoot = "./webroot"

var routes = makeURLRoutes()

server.addRoutes(routes)
server.serverPort = 8080

do {
	try server.start()
} catch PerfectError.networkError(let err, let msg) {
	print("Network error thrown: \(err) \(msg)")
}
