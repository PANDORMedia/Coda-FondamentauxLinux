from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer

host = "0.0.0.0"
port = 8080

server = ThreadingHTTPServer((host, port), SimpleHTTPRequestHandler)
print(f"Serving on http://{host}:{port}")
server.serve_forever()
