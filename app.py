from flask import Flask
import os

app = Flask(__name__)

# BAD PRACTICE: Hardcoded credentials
API_KEY = "hardcoded-api-key-123"

@app.route("/")
def home():
    secret = os.getenv("SECRET_KEY", "no-secret-found")
    return f"Insecure App Running. Secret: {secret}"

if __name__ == "__main__":
    # BAD PRACTICE: Debug mode enabled, 0.0.0.0 exposure
    app.run(host="0.0.0.0", port=80, debug=True)