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
            }
            service {
                name = "epicsax"
                port = "http"
        
 #               tags = [
 #                 "traefik.enable=true",
 #                 "traefik.http.routers.http.rule=Path(`/epicsax`)",
 #               ]
        
              }
        }
    }
}