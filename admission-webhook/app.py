from flask import Flask, jsonify, request
import os
import json
import logging
cert = os.environ.get('TLS_CRT', '/certs/tls.crt')
key = os.environ.get('TLS_KEY', '/certs/tls.key')

app = Flask(__name__)
logging.basicConfig(level=logging.DEBUG)

@app.route("/validate", methods=["POST"])
def validate():
    request_json = request.get_json()
    # requestjson = json.loads(str(request_json))
    deployment = request_json["request"]["object"]["spec"]["template"]["spec"]["containers"]
    # return deployment
    logging.debug("Request JSON: %s", deployment)


    for container in deployment:
        if "livenessProbe" in container and "readinessProbe" in container:
            response = {
                "apiVersion": "admission.k8s.io/v1",
                "kind": "AdmissionReview",
                "response": {
                    "uid": request_json["request"]["uid"],
                    "allowed": True,
                }
            }
            return jsonify(response)
        else:
            response = {
                "apiVersion": "admission.k8s.io/v1",
                "kind": "AdmissionReview",
                "response": {
                    "uid": request_json["request"]["uid"],
                    "allowed": False,
                    "status": {
                        "message": "livenessProbe is required in Deployment spec."
                    }
                }
            }
            return jsonify(response)

if __name__ == "__main__":
   app.run(host='0.0.0.0', debug=True, port=8443, ssl_context=(cert, key))
    #app.run(host='0.0.0.0', port=8443)

