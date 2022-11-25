job "epicServer" {
    datacenters = ["dc1"]
    group "musthaveepiclabel"{
        network {
            port "http" { static = 8076 }
        }
        task "webservice" {
            driver = "docker"
            config {
                image = "ghcr.io/dalsmo/epicsax:latest"
                network_mode = "host"
                ports = ["http"]
            }
            service {
                name = "epicsax"
                port = "http"
        
                tags = [
                  "traefik.enable=true",
                  "traefik.http.routers.episax-router.rule=PathPrefix(`/epicsax`)",
                  "traefik.http.middlewares.episax-stripprefix.stripprefix.prefixes=/epicsax",
                  "traefik.http.routers.episax-router.middlewares=episax-stripprefix",
                ]
        
              }
        }
    }
}