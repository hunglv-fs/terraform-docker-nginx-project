# Terraform Docker Nginx Project

This project sets up a multi-container environment using Terraform and Docker. It includes the following services:

## Services

1. **Nginx**: Acts as a reverse proxy for routing traffic.
2. **PostgreSQL**: A relational database for backend storage.
3. **Redis**: A caching layer for the backend.
4. **Node.js Backend**: A REST API built with Node.js, PostgreSQL, and Redis.
5. **React Frontend**: A React-based web application.
6. **Adminer**: A database management UI for PostgreSQL.

## Project Structure

```
.
├── backend/
│   ├── .env                # Environment variables for the backend
│   ├── db.js               # PostgreSQL connection setup
│   ├── redis.js            # Redis connection setup
│   ├── server.js           # Express server for the backend API
│   └── package.json        # Backend dependencies
├── frontend/
│   ├── public/
│   │   └── index.html      # React app entry point
│   ├── src/
│   │   ├── App.js          # Main React component
│   │   └── index.js        # React DOM rendering
│   └── package.json        # Frontend dependencies
├── main.tf                 # Terraform configuration for Docker resources
├── variables.tf            # Terraform variables
├── outputs.tf              # Terraform outputs
├── nginx.conf              # Nginx configuration
└── .gitignore              # Ignored files
```

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) (v1.3.3 or later)
- [Docker](https://www.docker.com/)
- Node.js (for local development of backend/frontend)

## Setup Instructions

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd terraform-docker/nginx
   ```

2. **Initialize Terraform**:
   ```bash
   terraform init
   ```

3. **Apply Terraform configuration**:
   ```bash
   terraform apply
   ```

4. **Access the services**:
   - Nginx: [http://localhost:8080](http://localhost:8080)
   - Backend API: [http://localhost:4000](http://localhost:4000)
   - Frontend: [http://localhost:3000](http://localhost:3000)
   - Adminer: [http://localhost:8081](http://localhost:8081)

## Environment Variables

The backend uses the following environment variables (defined in `backend/.env`):
- `DATABASE_URL`: PostgreSQL connection string
- `REDIS_HOST`: Redis hostname

## Notes

- The project uses the `kreuzwerker/docker` Terraform provider.
- All services are connected via a custom Docker network (`my_network`).

## License

This project is licensed under the [Mozilla Public License Version 2.0](https://www.mozilla.org/en-US/MPL/2.0/).
