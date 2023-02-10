from flask import Flask, make_response

app = Flask(__name__)

@app.route('/health-check')
def health_check():
    response = make_response('OK', 200)
    return response

if __name__ == '__main__':
    app.run(port=8080, debug=True)
