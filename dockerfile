FROM python:3.11.1-bullseye
RUN apt update
RUN apt upgrade -y

RUN mkdir -p admission-webhook
COPY app.py /admission-webhook
COPY requirements.txt /admission-webhook

RUN useradd -ms /bin/bash app_user
WORKDIR /admission-webhook
RUN python3 -m venv /admission-webhook/venv
RUN /admission-webhook/venv/bin/pip3 install -r /admission-webhook/requirements.txt
USER app_user
CMD /admission-webhook/venv/bin/python3 app.py