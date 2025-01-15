from flask import Flask, request, jsonify, render_template
from health_utils import calculate_bmi, calculate_bmr
import os

app = Flask(__name__, template_folder="templates")

@app.route('/bmi', methods=['POST'])
def bmi():
    data = request.get_json()
    if not data or 'height' not in data or 'weight' not in data:
        return jsonify({'error': 'Invalid input. Please provide height and weight.'}), 400
    height = data['height']
    weight = data['weight']
    result = calculate_bmi(height, weight)
    return jsonify({'BMI': result})

@app.route('/bmr', methods=['POST'])
def bmr():
    data = request.get_json()
    required_fields = ['height', 'weight', 'age', 'gender']
    if not data or not all(field in data for field in required_fields):
        return jsonify({'error': f'Invalid input. Please provide {", ".join(required_fields)}.'}), 400
    height = data['height']
    weight = data['weight']
    age = data['age']
    gender = data['gender']
    result = calculate_bmr(height, weight, age, gender)
    return jsonify({'BMR': result})

@app.route('/')
def index():
    return render_template('home.html')

if __name__ == '__main__':
    if not os.path.exists("templates/home.html"):
        raise FileNotFoundError("Le fichier home.html est manquant dans le dossier 'templates'")
    app.run(host='0.0.0.0', port=5000)

