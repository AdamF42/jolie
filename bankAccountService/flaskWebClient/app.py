from flask import Flask, flash, redirect, render_template, request, session, abort
from suds.client import Client as SudsClient
import urllib, os

url = urllib.parse.urljoin('file:', urllib.request.pathname2url(os.path.abspath("myWsdl.wsdl")))

client = SudsClient(url=url, cache=None)
print(client)

app = Flask(__name__)

@app.route("/",methods=['GET'])
def login():
    print("login => methods=['GET']")
    return render_template(
        'login.html')

@app.route("/register",methods=['GET'])
def register():
    print("register => methods=['GET']")
    return render_template(
        'register.html')

@app.route('/', methods=['POST'])
def index():
    print("index => methods=['POST']")
    username = request.form['username']
    password = request.form['password']
    print(username+" "+password)
    response = client.service.login(password, username)
    if response.status=="FAILURE":
        return render_template(
            'register.html',name=username)
    return render_template(
        'index.html',name=username)

@app.route('/register', methods=['POST'])
def index2():
    print("index2 => methods=['POST']")
    username = request.form['username']
    password = request.form['password']
    print(username+" "+password)
    response = client.service.register(password, username)
    if response.status=="FAILURE":
        return render_template(
            'register.html',name=username)
    return render_template(
        'index.html',name=username)




if __name__ == "__main__":
    app.run(host='0.0.0.0', port=80, debug=True)
