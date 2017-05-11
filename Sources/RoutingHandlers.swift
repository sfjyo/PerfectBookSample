import PerfectHTTP
import PerfectMustache

func makeURLRoutes() -> Routes {
	var routes = Routes()
	routes.add(method: .get, uri: "/", handler: indexHandler)
	routes.add(method: .get, uri: "/new", handler: newHandler)
	routes.add(method: .post, uri: "/create", handler: createHandler)
	routes.add(method: .get, uri: "/edit/{id}", handler: editHandler)
	routes.add(method: .post, uri: "/update/{id}", handler: updateHandler)
	routes.add(method: .get, uri: "/destroy/{id}", handler: deleteHandler)
	return routes
}

func indexHandler(request: HTTPRequest, _ response: HTTPResponse) {
	response.setHeader(.contentType, value: "text/html")
	mustacheRequest(
			request: request,
			response: response,
			handler: IndexHandler(),
			templatePath: request.documentRoot + "/index.mustache"
		)
		// Signalling that the request is completed
		response.completed()
}

func newHandler(request: HTTPRequest, _ response: HTTPResponse) {
	response.setHeader(.contentType, value: "text/html")
	mustacheRequest(
			request: request,
			response: response,
			handler: NewHandler(),
			templatePath: request.documentRoot + "/new.mustache"
		)
		// Signalling that the request is completed
		response.completed()
}

func createHandler(request: HTTPRequest, _ response: HTTPResponse) {
	response.setHeader(.contentType, value: "text/html")
	mustacheRequest(
			request: request,
			response: response,
			handler: CreateHandler(),
			templatePath: request.documentRoot + "/show.mustache"
		)
		// Signalling that the request is completed
		response.completed()
}

func editHandler(request: HTTPRequest, _ response: HTTPResponse) {
	response.setHeader(.contentType, value: "text/html")
	mustacheRequest(
			request: request,
			response: response,
			handler: EditHandler(),
			templatePath: request.documentRoot + "/edit.mustache"
		)
		// Signalling that the request is completed
		response.completed()
}

func updateHandler(request: HTTPRequest, _ response: HTTPResponse) {
	response.setHeader(.contentType, value: "text/html")
	mustacheRequest(
			request: request,
			response: response,
			handler: UpdateHandler(),
			templatePath: request.documentRoot + "/show.mustache"
		)
		// Signalling that the request is completed
		response.completed()
}

func deleteHandler(request: HTTPRequest, _ response: HTTPResponse) {
	response.setHeader(.contentType, value: "text/html")
	mustacheRequest(
			request: request,
			response: response,
			handler: DeleteHandler(),
			templatePath: request.documentRoot + "/index.mustache"
		)
		// Signalling that the request is completed
		response.completed()
}
