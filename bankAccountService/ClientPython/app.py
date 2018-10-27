from flask import Flask, flash, redirect, render_template, request, session, abort
from suds.client import Client as SudsClient
import urllib, os

url = urllib.parse.urljoin('file:', urllib.request.pathname2url(os.path.abspath("myWsdl.wsdl")))

client = SudsClient(url=url, cache=None)
print(client)

app = Flask(__name__, template_folder="Views")

@app.route("/",methods=['GET'])
def login():
    print("login => methods=['GET']");
    return render_template(
        'login.html')

@app.route("/register",methods=['GET'])
def register():
    print("register");
    return render_template(
        'register.html')

@app.route('/', methods=['POST'])
def index():
    username = request.form['username']
    password = request.form['password']
    # username = "request.form['username']"
    # password = "request.form['password']"
    response = client.service.login(password, username)
    if response.status=="FAILURE":
        return render_template(
            'register.html',name=username)
    return render_template(
        'index.html',name=username)


@app.route("/hello/<string:name>/")
def hello(name):
    return render_template(
        'index.html',name=name)

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=80)
