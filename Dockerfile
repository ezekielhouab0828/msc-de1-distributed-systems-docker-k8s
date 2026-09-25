FROM python:3.11-slim

# 1. Créer un utilisateur non-root AVEC UID NUMÉRIQUE
RUN useradd -u 1000 -m appuser

# 2. Dossier de travail
WORKDIR /app

# 3. Copier les dépendances
COPY requirements.txt .

# 4. Installer les dépendances
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copier le code de l'application
COPY . .

# 6. Donner les permissions à l'utilisateur non-root
RUN chown -R 1000:1000 /app

# 7. Utiliser l'utilisateur non-root
USER 1000

# 8. Exposer le port Flask
EXPOSE 5000

# 9. Lancer l'application
CMD ["python", "run.py"]