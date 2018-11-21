# cache hit
curl -I http://proxy.minerva.net:88

# bypass cache
curl -I http://proxy.minerva.net:88 -H "secret-header: true"