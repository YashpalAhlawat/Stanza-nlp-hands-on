#4 workers will run bind the address 0.0.0.0 at 8080 port, -k gevent is telling gunicorn to use async workers for better I/O main.py as app. It can handle 10000 max request at peak, timeout is 300 sec
gunicorn --workers 4 --bind 0.0.0.0:8080 -k gevent main:app --max-requests 10000 --timeout 300 --keep-alive 5 --log-level info

