curl -X POST http://localhost:8001/services \
  --data name=httpbin \
  --data url=http://httpbin.org

curl -X POST http://localhost:8001/services/httpbin/routes \
  --data paths[]=/httpbin

echo "Test with:"
echo "curl http://localhost:8000/httpbin/get"
