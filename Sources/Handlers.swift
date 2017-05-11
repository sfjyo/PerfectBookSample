import PerfectLib
import PerfectHTTP
import PerfectMustache

struct IndexHandler: MustachePageHandler {
	func extendValuesForResponse(context contxt: MustacheWebEvaluationContext, collector: MustacheEvaluationOutputCollector) {
		var values = MustacheWebEvaluationContext.MapType()
		var ary = [Any]()

		let book = Book()
		try? book.findAll()

		for row in book.rows() {
			ary.append(row.asDictionary())
		}
		values["posts"] = ary
		contxt.extendValues(with: values)

		do {
			try contxt.requestCompleted(withCollector: collector)
		} catch {
			let response = contxt.webResponse
			response.status = .internalServerError
			response.appendBody(string: "\(error)")
			response.completed()
		}
	}
}

struct NewHandler: MustachePageHandler {
	func extendValuesForResponse(context contxt: MustacheWebEvaluationContext, collector: MustacheEvaluationOutputCollector) {
		var values = MustacheWebEvaluationContext.MapType()

		let book = Book()

		values["book"] = book.asDictionary()
		contxt.extendValues(with: values)

		do {
			try contxt.requestCompleted(withCollector: collector)
		} catch {
			let response = contxt.webResponse
			response.status = .internalServerError
			response.appendBody(string: "\(error)")
			response.completed()
		}
	}
}

struct CreateHandler: MustachePageHandler {
	func extendValuesForResponse(context contxt: MustacheWebEvaluationContext, collector: MustacheEvaluationOutputCollector) {
		let request = contxt.webRequest
		var values = MustacheWebEvaluationContext.MapType()

		let book = Book()
		book.title = request.param(name: "title", defaultValue: "") ?? ""
		book.name = request.param(name: "name", defaultValue: "") ?? ""

		do {
			try book.save {
				id in book.id = id as! Int
			}

			values["book"] = book.asDictionary()
			contxt.extendValues(with: values)

			try contxt.requestCompleted(withCollector: collector)
		} catch {
			let response = contxt.webResponse
			response.status = .internalServerError
			response.appendBody(string: "\(error)")
			response.completed()
		}
	}
}

struct EditHandler: MustachePageHandler {
	func extendValuesForResponse(context contxt: MustacheWebEvaluationContext, collector: MustacheEvaluationOutputCollector) {
		let request = contxt.webRequest
		var values = MustacheWebEvaluationContext.MapType()

		do {
			let book = Book()
			let id = request.urlVariables["id"] ?? ""
			if id != "" {
				try book.get(id)
			}

			values["book"] = book.asDictionary()
			contxt.extendValues(with: values)

			try contxt.requestCompleted(withCollector: collector)
		} catch {
			let response = contxt.webResponse
			response.status = .internalServerError
			response.appendBody(string: "\(error)")
			response.completed()
		}
	}
}

struct UpdateHandler: MustachePageHandler {
	func extendValuesForResponse(context contxt: MustacheWebEvaluationContext, collector: MustacheEvaluationOutputCollector) {
		let request = contxt.webRequest
		var values = MustacheWebEvaluationContext.MapType()

		do {
			let book = Book()
			let id = request.urlVariables["id"] ?? ""
			if id != "" {
				try book.get(id)

				book.title = request.param(name: "title", defaultValue: "") ?? ""
				book.name = request.param(name: "name", defaultValue: "") ?? ""
			}

			values["book"] = book.asDictionary()
			contxt.extendValues(with: values)

			if id != "" {
				try book.save()
			}

			try contxt.requestCompleted(withCollector: collector)
		} catch {
			let response = contxt.webResponse
			response.status = .internalServerError
			response.appendBody(string: "\(error)")
			response.completed()
		}
	}
}

struct DeleteHandler: MustachePageHandler {
	func extendValuesForResponse(context contxt: MustacheWebEvaluationContext, collector: MustacheEvaluationOutputCollector) {
		let request = contxt.webRequest
		var values = MustacheWebEvaluationContext.MapType()
		var ary = [Any]()

		let book = Book()
		let id = request.urlVariables["id"] ?? ""
		do {
			if id != "" {
				try book.delete(id)
			}
		} catch {
		}

		try? book.findAll()
		for row in book.rows() {
			ary.append(row.asDictionary())
		}
		values["posts"] = ary
		contxt.extendValues(with: values)

		do {
			try contxt.requestCompleted(withCollector: collector)
		} catch {
			let response = contxt.webResponse
			response.status = .internalServerError
			response.appendBody(string: "\(error)")
			response.completed()
		}
	}
}
