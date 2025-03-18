output "nginx_url" {
  value = "http://localhost:8080"
}

output "backend_api" {
  value = "http://localhost:4000"
}

output "frontend_url" {
  value = "http://localhost:3000"
}

output "database_url" {
  value = "postgres://admin:adminpass@localhost:5432/mydb"
}

output "adminer_url" {
  value = "http://localhost:8081"
}

output "module_path" {
  value = path.module
}