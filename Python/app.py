from flask import Flask

from String import hello

app = Flask(__name__)


@app.route('/prova')
def hello_world():
    if hello() == "true":
        return "", 200
    else:
        return "", 300


if __name__ == '__main__':
    app.run()
