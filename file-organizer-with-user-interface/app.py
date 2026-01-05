from flask import Flask, render_template, request
import subprocess

app = Flask(__name__)

@app.route("/", methods=["GET", "POST"])
def index():
    message = ""
    if request.method == "POST":
        path = request.form["path"]

        if "organize" in request.form:
            subprocess.run(["bash", "organizer.sh", path])
            message = "Files organized successfully."

        elif "undo" in request.form:
            subprocess.run(["bash", "undo.sh"])
            message = "Recovery completed."

    return render_template("index.html", message=message)

app.run(debug=True)
