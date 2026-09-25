Distributed Systems – Docker, KIND & Kubernetes
MSc DE1 – Projet académique
Auteur : Ezekiel Houabaloukou

🚀 Introduction
Ce projet met en œuvre une application Flask conteneurisée et déployée dans un cluster Kubernetes local via KIND.
Il illustre les concepts fondamentaux des systèmes distribués :

Conteneurisation (Docker)

Orchestration (Kubernetes)

Scaling automatique

Rolling updates

Reverse proxy via Ingress

Sécurité (SBOM + Trivy)

CI/CD local (build → load → deploy)

📁 Structure du dépôt
Code
.
├── app/                     # Application Flask
│   ├── static/
│   ├── templates/
│   ├── app.py
│   ├── config.py
│   └── requirements.txt
│
├── docker/
│   ├── Dockerfile
│   └── compose.yaml
│
├── k8s/
│   ├── namespace.yaml
│   ├── deployment.yaml
│   ├── service.yaml
│   └── ingress.yaml
│
├── kind/
│   └── kind-config.yaml
│
├── security/
│   ├── sbom.json
│   ├── trivy-report.txt
│   └── flask-sample-app.tar
│
├── urls.txt
└── README.md
🏗️ Architecture du système
Code
                         ┌──────────────────────────┐
                         │        Client Web         │
                         └──────────────┬───────────┘
                                        │
                                        ▼
                          ┌──────────────────────────┐
                          │      Ingress Controller   │
                          └──────────────┬───────────┘
                                        │
                                        ▼
                         ┌──────────────────────────┐
                         │   Service (ClusterIP)     │
                         └──────────────┬───────────┘
                                        │
                                        ▼
                         ┌──────────────────────────┐
                         │ Deployment (Flask App)   │
                         │   • Pods (replicas)      │
                         │   • Rolling updates      │
                         └──────────────────────────┘
🐳 Docker
🔨 Build
Code
docker build -t flask-sample-app:latest .
▶️ Run
Code
docker run -p 5000:5000 flask-sample-app
🧩 Compose
Code
docker compose up --build
☸️ Kubernetes avec KIND
1️⃣ Créer le cluster
Code
kind create cluster --config kind/kind-config.yaml
2️⃣ Charger l’image dans KIND
Code
kind load docker-image flask-sample-app:latest
3️⃣ Déployer
Code
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl apply -f k8s/ingress.yaml
4️⃣ Vérifier
Code
kubectl get pods -n flask-app
kubectl get svc -n flask-app
kubectl get ingress -n flask-app
🔄 Rolling Update
Modifier dans deployment.yaml :

Code
image: flask-sample-app:v2
Puis :

Code
kubectl apply -f k8s/deployment.yaml
kubectl rollout status deployment flask-app -n flask-app
🛡️ Sécurité
Le dossier security/ contient :

SBOM généré via Syft

Scan Trivy (vulnérabilités)

Archive du projet (flask-sample-app.tar)

⚠️ GitHub signale que flask-sample-app.tar dépasse 50 MB.
Ce n’est pas bloquant, mais GitHub recommande Git LFS.

🌐 URLs demandées
Code
GitHub : https://github.com/ezekielhouab0828/msc-de1-distributed-systems-docker-k8s
Docker Hub : https://hub.docker.com/r/<ton_user>/flask-sample-app
Ingress local : http://localhost/
📚 Technologies
Python 3.10

Flask

Docker

KIND

Kubernetes

Trivy

Syft

YAML

GitHub

👨‍💻 Auteur
Ezekiel Houabaloukou  
MSc Data Engineering – 2026
