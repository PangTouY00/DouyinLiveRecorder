FROM python:3.11-slim

WORKDIR /app

COPY . /app

RUN apt-get update && \
    apt-get install -y curl gnupg && \
    curl -sL https://deb.nodesource.com/setup_20.x  | bash - && \
    apt-get install -y nodejs

RUN apt-get update && apt-get install -y build-essential libssl-dev libffi-dev python3-dev curl
RUN pip install --upgrade pip setuptools
RUN pip install --extra-index-url https://www.piwheels.org/simple pycryptodome==3.20.0
RUN pip install --extra-index-url https://www.piwheels.org/simple PyExecJS
RUN pip install --no-cache-dir -r requirements.txt

RUN apt-get update && \
    apt-get install -y ffmpeg tzdata && \
    ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

CMD ["python", "main.py"]
