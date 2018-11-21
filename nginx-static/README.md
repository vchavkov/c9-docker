# cache hit
curl -I http://proxy.minerva.net/test

# bypass cache
curl -I http://proxy.minerva.net/test -H "secret-header: true"

# purge cache
curl -I http://proxy.minerva.net/purge/test
