from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/')
def index():
    return "Hello from Flask Microservice!"

@app.route('/health')
def health():
    return jsonify(status="UP"), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

