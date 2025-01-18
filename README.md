# DevOps Project - BMR & BMI Calculator

Ce projet est une application web destinée à calculer le **BMR (Basal Metabolic Rate)** et le **BMI (Body Mass Index)**, avec un pipeline CI/CD automatisé utilisant GitHub Actions pour déploiement sur Azure Web Apps.

## Fonctionnalités principales

- Calcul du **BMR** (taux métabolique de base) en fonction de la taille, du poids, de l'âge et du sexe.
- Calcul du **BMI** (indice de masse corporelle) pour évaluer l'état de santé basé sur le poids et la taille.
- Interface web simple pour entrer les données et afficher les résultats.
- Intégration d'un pipeline CI/CD avec GitHub Actions pour automatiser les tests et le déploiement.

## Technologies utilisées

- **Backend** : Flask (Python)
- **Frontend** : HTML/CSS (fichier `home.html` dans le dossier `templates`)
- **CI/CD** : GitHub Actions
- **Déploiement** : Azure Web Apps

## Prérequis

- **Python 3.x** installé localement
- **Git** pour la gestion du dépôt
- Compte Azure avec un service App Service configuré
- Secrets GitHub configurés :
  - `AZURE_CLIENT_ID`
  - `AZURE_TENANT_ID`
  - `AZURE_SUBSCRIPTION_ID`
  - `AZURE_CLIENT_SECRET`

## Installation locale

1. Clonez le dépôt :
   ```bash
   git clone https://github.com/admngn/DevOps-project.git
   cd DevOps-project
   ```

2. Créez un environnement virtuel et activez-le :
   ```bash
   python -m venv venv
   source venv/bin/activate  # macOS/Linux
   venv\Scripts\activate   # Windows
   ```

3. Installez les dépendances :
   ```bash
   pip install -r requirements.txt
   ```

4. Exécutez l'application localement :
   ```bash
   python app.py
   ```

5. Accédez à l'application dans votre navigateur à l'URL :
   ```
   http://127.0.0.1:5000/
   ```

## Déploiement avec GitHub Actions

1. Poussez vos modifications dans la branche `main`.
2. Le pipeline CI/CD dans `.github/workflows/pipeline.yaml` sera automatiquement exécuté :
   - Installation des dépendances
   - Exécution des tests unitaires
   - Création d'un artefact ZIP contenant les fichiers nécessaires
   - Déploiement sur Azure Web Apps
3. Accédez à l'application déployée à l'URL :
   ```
   https://bmr-bmiwebapp.azurewebsites.net
   ```

## Structure du projet

```
DevOps-project/
├── templates/
│   └── home.html         # Fichier HTML principal pour l'interface utilisateur
├── app.py                # Backend Flask pour gérer les calculs et les routes
├── requirements.txt      # Liste des dépendances Python
├── .github/workflows/
│   └── pipeline.yaml     # Pipeline CI/CD GitHub Actions
└── README.md             # Documentation du projet
```

## Pipeline CI/CD

Le pipeline CI/CD inclut les étapes suivantes :

1. **Clonage du code source** : Télécharge le dépôt depuis GitHub.
2. **Installation des dépendances** : Configure l'environnement Python et installe les dépendances nécessaires.
3. **Tests unitaires** : Exécute les tests définis dans `test.py` pour valider les calculs et fonctionnalités.
4. **Création d'un artefact** : Zippe les fichiers nécessaires pour le déploiement.
5. **Déploiement** : Envoie les fichiers sur Azure Web Apps.

## Tests unitaires

Les tests sont situés dans le fichier `test.py` et utilisent le module `unittest`. Ils valident les calculs du BMR et du BMI.

Pour exécuter les tests localement :
```bash
python -m unittest discover
```
