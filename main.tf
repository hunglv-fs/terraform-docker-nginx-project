terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

# Tạo một Docker network cho các dịch vụ
resource "docker_network" "my_network" {
  name = "my_network"
}

# 1️⃣ Nginx - Reverse Proxy
resource "docker_image" "nginx" {
  name = "nginx:latest"
}

resource "docker_container" "nginx" {
  name  = "nginx_proxy"
  image = docker_image.nginx.name
  networks_advanced {
    name = docker_network.my_network.name
  }
  ports {
    internal = 80
    external = 8080
  }
  volumes {
    host_path      = "${var.my_module_path}/nginx/nginx.conf"
    container_path = "/etc/nginx/nginx.conf"
  }
  depends_on = [docker_container.nodejs]
}

# 2️⃣ PostgreSQL - Database
resource "docker_image" "postgres" {
  name = "postgres:16"
  
}

resource "docker_container" "postgres" {
  name  = "postgres_db"
  image = docker_image.postgres.name
  networks_advanced {
    name = docker_network.my_network.name
  }
  env = [
    "POSTGRES_USER=admin",
    "POSTGRES_PASSWORD=adminpass",
    "POSTGRES_DB=mydb"
  ]
  ports {
    internal = 5432
    external = 5432
  }
}

# 3️⃣ Redis - Caching
resource "docker_image" "redis" {
  name = "redis:latest"
  
}

resource "docker_container" "redis" {
  name  = "redis_cache"
  image = docker_image.redis.name
  networks_advanced {
    name = docker_network.my_network.name
  }
  ports {
    internal = 6379
    external = 6379
  }
  
}

# 4️⃣ Node.js App - Backend API
resource "docker_image" "nodejs_app" {
  name = "node:18"
}

resource "docker_container" "nodejs" {
  name  = "node_api"
  image = docker_image.nodejs_app.name
  networks_advanced {
    name = docker_network.my_network.name
  }
  command = ["sh", "-c", "npm install && node server.js"]
  working_dir = "/app"
  volumes {
    host_path      = "${var.my_module_path}/backend"
    container_path = "/app"
  }
  env = [
    "DATABASE_URL=postgres://admin:adminpass@postgres_db:5432/mydb",
    "REDIS_HOST=redis_cache"
  ]
  depends_on = [docker_container.postgres, docker_container.redis]
  # ports {
  #   internal = 4000
  #   external = 4000
  # }
}

# 5️⃣ React App - Frontend Web
resource "docker_image" "react_app" {
  name = "node:18"
  
}

resource "docker_container" "react_frontend" {
  name  = "react_frontend"
  image = docker_image.react_app.name
  networks_advanced {
    name = docker_network.my_network.name
  }
  command = ["sh", "-c", "npm install && npm start"]
  working_dir = "/app"
  volumes {
    host_path      = "${var.my_module_path}/frontend"
    container_path = "/app"
  }
  # ports {
  #   internal = 3000
  #   external = 3000
  # }
  depends_on = [docker_container.nodejs]
  
}

# 6️⃣ Adminer - UI quản lý database
resource "docker_image" "adminer" {
  name = "adminer:latest"
  
}

resource "docker_container" "adminer" {
  name  = "adminer_ui"
  image = docker_image.adminer.name
  networks_advanced {
    name = docker_network.my_network.name
  }
  ports {
    internal = 8080
    external = 8081
  }
  depends_on = [docker_container.postgres]
  
}
