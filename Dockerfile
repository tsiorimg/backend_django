# Utiliser une image Python officielle comme image parent
FROM python:3.9-slim

# Installer les dépendances nécessaires
RUN apt-get update && apt-get install -y libpq-dev gcc

# Définir le répertoire de travail
WORKDIR /app

# Copier le fichier de configuration des dépendances
COPY requirements.txt /app/

# Installer les dépendances Python
RUN pip install --no-cache-dir -r requirements.txt

# Copier le reste des fichiers du projet
COPY . /app/

# Collecter les fichiers statiques
RUN python manage.py collectstatic --noinput

# Exposer le port sur lequel l'application fonctionnera
EXPOSE 8000

# Commande pour démarrer le serveur Django avec Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "backend_django.wsgi:application"]
