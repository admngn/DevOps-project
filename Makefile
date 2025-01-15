DOCKER_IMAGE := health-calculator-service
PORT := 5000

help:
	@echo "Commandes disponibles:"
	@echo "  help           - Afficher cette aide"
	@echo "  env            - Créer un environnement virtuel nommé venv (si inexistant)"
	@echo "  init           - Initialiser le projet (créer venv et installer les dépendances)"
	@echo "  install        - Installer les dépendances Python"
	@echo "  build          - Construire l'image Docker health-calculator-service"
	@echo "  run            - Lancer l'application Flask localement sur le port 5000"
	@echo "  test           - Exécuter tous les tests unitaires"
	@echo "  test(utils)    - Exécuter uniquement les tests unitaires pour health_utils.py"
	@echo "  test(api)      - Tester les endpoints API avec des commandes curl"
	@echo "  api            - Lancer l'application Flask via Docker sur le port 5000"
	@echo "  clean          - Supprimer les fichiers temporaires et l'environnement virtuel"

env:
	@if [ ! -d "venv" ]; then \
		echo "Création de l'environnement virtuel venv..."; \
		python3 -m venv venv; \
		echo "Activation de venv et mise à jour de pip..."; \
		. venv/bin/activate && pip install --upgrade pip; \
	else \
		echo "L'environnement virtuel venv existe déjà."; \
	fi

init: env install

install:
	@echo "Installation des dépendances Python..."
	. venv/bin/activate && pip install -r requirements.txt

build:
	@echo "Construction de l'image Docker : health-calculator-service"
	docker build -t health-calculator-service .

run:
	@echo "Lancement de l'application Flask sur le port 5000..."
	. venv/bin/activate && python app.py

test:
	@echo "Exécution de tous les tests unitaires..."
	. venv/bin/activate && python -m unittest discover -s . -p "*.py"

test(utils):
	@echo "Exécution des tests pour health_utils.py..."
	. venv/bin/activate && python -m unittest test.py

test(api):
	@echo "Test du endpoint /bmi..."
	curl -X POST http://127.0.0.1:5000/bmi -H "Content-Type: application/json" -d '{"height": 1.75, "weight": 70}'
	@echo "\nTest du endpoint /bmr..."
	curl -X POST http://127.0.0.1:5000/bmr -H "Content-Type: application/json" -d '{"height": 175, "weight": 70, "age": 25, "gender": "male"}'

api:
	@echo "Lancement de l'application Flask dans un conteneur Docker sur le port 5000..."
	docker run -d -p 5000:5000 health-calculator-service

clean:
	@echo "Nettoyage des fichiers temporaires et de l'environnement virtuel..."
	find . -type f -name '*.pyc' -delete
	find . -type d -name '__pycache__' -exec rm -rf {} +
	rm -rf venv

all: init build api
