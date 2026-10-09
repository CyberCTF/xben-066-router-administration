#!/bin/sh
# A login through mitmproxy, HAProxy and the router app reaches the database and is refused.
curl -fsS --max-time 20 -d 'username=nobody&password=probe' http://mitmproxy:8002/login | grep -q 'Invalid username.'
