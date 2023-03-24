De Dedededode De de!

# run me in docker like so
docker build --rm -t golang-docker-example . && docker run -p 8081:8081 golang-docker-example

# somthing to fiddle the container
kubectl port-forward service/epic 8076:8076