from flask import Flask, request
import os
import json
import pathlib
from face_util import face_rec, compare_faces

app = Flask(__name__)


@app.route('/face_rec', methods=['POST'])
def face_recognition():

    if request.method == 'POST':
        if 'image' in request.files:
            file = request.files.get('image').stream
            # x = pathlib.WindowsPath('abc').joinpath(file.filename)
            # abc = os.path.join('abc', 'kubilay5.png')
            # file.save(abc)

            name = face_rec(file)

            resp_data = {'name': name}
            return json.dumps(resp_data)


app.run(host='192.168.1.7', port='5002', debug=True)
