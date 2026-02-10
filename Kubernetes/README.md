# kong-helm-sandbox Traditional deployment
learning kong helm

## Structure
```
kong-helm-sandbox/
  └── values.yaml
```

# What is helm
helm is package manager for kubernetes

**Create namespace**
```bash
kubectl create namespace kong-trad
```

## 1️⃣ Set up CloudNativePG
### **Install CloudNativePG**
Install the operator manifest
```bash
kubectl apply --server-side -f https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/release-1.27/releases/cnpg-1.27.1.yaml
```
Verify that with
```bash
kubectl rollout status deployment -n cnpg-system cnpg-controller-manager
```

## **2️⃣ Create Secret**
Create file pg-kong-user.yaml
```bash
kubectl apply -f pg-kong-user.yaml -n kong-trad
```

### **3️⃣Deploy a PostgreSQL cluster**
Create file pg.yaml
```bash
kubectl apply -f pg.yaml -n kong-trad
```

### **Verify PG**
```bash
kubectl exec -it kong-pg-1 -- psql -U postgres -n kong-trad
```
---

## **Setup Kong**

### Step 1 Add Repository
Run command: 
```bash
helm repo add kong https://charts.konghq.com -n kong-trad

helm repo update
```

Check repo list
Run command: 
```bash
helm repo list -n kong-trad
```

### Step 2 Create file values.yaml
Create values.yaml

### Step 4 Install Kong with helm (helm install)
Run command: 
```bash
helm install kong kong/kong --namespace kong-trad -f values.yaml
```

Run command: 
```bash
helm list --namespace kong-trad
or
kubectl get pods -n kong-trad
```

### Step 5 Port-forward admin API (8001)
Check service by
```bash
kubectl get services -n kong-trad
```

Run command: 
```bash
kubectl port-forward svc/kong-kong-admin -n kong-trad 8001:8001
```

Check curl
```bash
curl http://localhost:8001/
```

### Step 6 Port-forward kong manager (8002)
Check service by
```bash
kubectl get services -n kong-trad
```

Run command: 
```bash
kubectl port-forward svc/kong-kong-manager -n kong-trad 8002:8002
```

Check curl
```bash
curl http://localhost:8002/
```

### Step 7 Sanity checks
Check Kong version
```bash
kubectl exec -it -n kong-trad deploy/kong-kong -c proxy -- kong version
```

Check env vars
```bash
kubectl exec -it -n kong-trad deploy/kong-kong -c proxy -- env | grep KONG_ADMIN_GUI
```

Check that port 8002 is listening in the pod
```bash
kubectl exec -it -n kong-trad deploy/kong-kong -c proxy -- netstat -tulpn | grep 8002
```

### Step 8 Test by creating a service
Run 
```bash
curl -i -X POST http://localhost:8001/services/ \
    --header "Accept: application/json" \
    --header "Content-Type: application/json" \
    --data '
    {
      "name": "example-service",
      "url": "http://httpbin.konghq.com"
    }
    '
```

Check in UI: http://localhost:8002/services

### Step 9 Test by creating a route
Run 
```bash
curl -X POST http://localhost:8001/services/mock-service/routes \
  -H "Content-Type: application/json" \
  -d '{
    "name": "example-route",
    "paths": ["/example"]
  }'
```

Check in UI: http://localhost:8002/route

### Step 10 Test by Add a plugin
```bash
curl -X POST http://localhost:8001/services/example-service/plugins \
  -H "Content-Type: application/json" \
  -d '{
    "name": "key-auth"
  }'
```

Check in UI: http://localhost:8002/plugins

### Step 11 Test Add a Consumer + API Key (optional)
```bash
# Create user
curl -X POST http://localhost:8001/consumers -d username=testuser
# Create key
curl -X POST http://localhost:8001/consumers/testuser/key-auth
```

Check in UI: http://localhost:8002/consumers

### Step 12 Test through Proxy
Port-forward kong proxy
Run command: 
```
kubectl port-forward svc/kong-kong-proxy -n kong-trad 8000:80

curl -i http://localhost:8000/mock
```

### Step 13 Test dump config
1.Install decK : https://developer.konghq.com/deck/

Run command: 
```
deck gateway dump -o kong-gw.yaml
```