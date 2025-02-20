# VolunteerHub

## Prerequisites

Ensure you have **Homebrew** installed on your macOS. If not, install it using:

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Installation

1. **Install Podman**:

   ```shell
   brew install podman
   ```

2. **Install Podman Compose**:

   ```shell
   brew install podman-compose
   ```

3. **Initialize Podman (if running for the first time)**:

   ```shell
   podman machine init
   podman machine start
   ```

## Building and Starting the App

Use **Podman Compose** to build and start the app:

```shell
podman compose -f ./docker-compose.yml -p volunteerhub up -d --build
```

This will:
- Build the necessary images
- Start the app in detached mode (`-d`)

If you have already built the containers and just need to start them, run:

```shell
podman compose -f ./docker-compose.yml -p volunteerhub up -d
```

Once the app is running, you can access it at:

🔗 **http://localhost:8080**

## Managing Containers

- **Stop the app**:

  ```shell
  podman compose -f ./docker-compose.yml -p volunteerhub down
  ```

- **Restart the app**:

  ```shell
  podman compose -f ./docker-compose.yml -p volunteerhub up -d
  ```

- **Check running containers**:

  ```shell
  podman ps
  ```

- **View logs**:

  ```shell
  podman logs -f <container_name>
  ```

## Notes

- Replace `<container_name>` with the actual container name (check `podman ps`).
- If you run into networking issues, you may need to restart the Podman machine:

  ```shell
  podman machine stop
  podman machine start
  ```

Now your **VolunteerHub** app is up and running with Podman! 🚀
