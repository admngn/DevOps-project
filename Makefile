VENV_DIR := venv
DOCKER_IMAGE := health-calculator-service
PORT := 5000

help:
	@echo "Commandes disponibles:"
	@echo "  help           - Afficher cette aide"
	@echo "  env            - Créer un environnement virtuel nommé venv"
	@echo "  init           - Initialiser le projet (créer venv et installer les dépendances)"
	@echo "  install        - Installer les dépendances Python"
	@echo "  build          - Construire l'image Docker health-calculator-service"
	@echo "  run            - Lancer l'application Flask localement sur le port 5000"
	@echo "  test           - Exécuter tous les tests unitaires"
	@echo "  test(utils)    - Exécuter uniquement les tests unitaires pour health_utils.py"
	@echo "  test(api)      - Tester les endpoints API avec des commandes curl"
	@echo "  api            - Lancer l'application Flask via Docker sur le port 5000"

# Créer l'environnement virtuel
env:
	@echo "Création de l'environnement virtuel venv..."
	python3 -m venv venv
	@echo "Activation de venv et mise à jour de pip..."
	. venv/bin/activate && pip install --upgrade pip

# Initialiser le projet (env + dépendances)
init: env install

# Installer les dépendances Python
install:
	@echo "Installation des dépendances Python..."
	. venv/bin/activate && pip install -r requirements.txt

# Construire l'image Docker
build:
	@echo "Construction de l'image Docker : health-calculator-service"
	docker build -t health-calculator-service .

# Lancer l'application Flask localement
run:
	@echo "Lancement de l'application Flask sur le port 5000..."
	. venv/bin/activate && python app.py

# Exécuter tous les tests unitaires
test:
	@echo "Exécution de tous les tests unitaires..."
	. venv/bin/activate && python -m unittest discover -s . -p "*.py"

# Exécuter uniquement les tests pour health_utils.py
test(utils):
	@echo "Exécution des tests pour health_utils.py..."
	. venv/bin/activate && python -m unittest test.py

# Tester les endpoints API avec curl
test(api):
	@echo "Test du endpoint /bmi..."
	curl -X POST http://127.0.0.1:5000/bmi -H "Content-Type: application/json" -d '{"height": 1.75, "weight": 70}'
	@echo "\nTest du endpoint /bmr..."
	curl -X POST http://127.0.0.1:5000/bmr -H "Content-Type: application/json" -d '{"height": 175, "weight": 70, "age": 25, "gender": "male"}'

# Lancer l'application Flask via Docker
api:
	@echo "Lancement de l'application Flask dans un conteneur Docker sur le port 5000..."
	docker run -p 5000:5000 health-calculator-service


all: env install build api
