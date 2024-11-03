from flask import Flask, request
# import keras
import random as rd
# import numpy as np

app = Flask(__name__)

@app.route("/")
def index():
    return '<marquee direction="right"><h1>API is up and running!</h1></marquee>'

@app.route("/section-heatmap", methods = ["POST"])
def heatmap():
    body = request.form

    width = int(body.get("width"))
    height = int(body.get("height"))
    section = int(body.get("section"))

    # model = keras.models.load_model('./tea_classifier.h5', compile=False)

    path = f"./images/section {section}/"
    predictions = []
    for i in range(1, width+1):
        row = []
        for j in range(1, height+1):
            # image_path = path+f"section_{section}_{i}_{j}.jpg"

            # img = keras.preprocessing.image.load_img(image_path, target_size = (256, 256, 3))
            # img_array = keras.preprocessing.image.img_to_array(img) / 255.0
            # img_array = np.expand_dims(img_array, axis = 0)

            # prediction: list = model.predict(img_array).tolist()

            # label = prediction[0].index(max(prediction[0]))

            label = rd.choice([0, 1, 2])

            row.append(label)
        predictions.append(row)

    return {"data": predictions}


if __name__ == "__main__":
    app.run(debug = True)