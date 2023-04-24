FROM python:3.8.13

# FROM 155577958684.dkr.ecr.ap-south-1.amazonaws.com/dso-devops-python:3.8.13-26052022

# Set up Labels for the image
LABEL Author=@admin \
      Version=1.0 \
      Maintainer=@admin

# Set up environment variable for base dir
# Basdir need to changes in Dockerfile, vision.ini, nginx/default, start.sh
ENV BASE_REPO_DIR=server

# Install base packages
RUN apt-get update && apt-get install -y --no-install-recommends libpangocairo-1.0-0 curl python3 python3-dev python3-setuptools \
    python3-pip libglib2.0-0 libsm6 libfontconfig1 libxrender1 libxext6 ca-certificates software-properties-common \
    python3-unidecode ffmpeg libsm6 libxext6 nginx build-essential cmake poppler-utils -y

RUN apt-get update && apt-get install -y --no-install-recommends ffmpeg libsm6 libxext6 libssl-dev openssl ca-certificates

# Update pip packages
RUN python3 -m pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org --upgrade pip

# Setting up workdir
WORKDIR /${BASE_REPO_DIR}

# Moving requirement file and install dependency packages
ADD ./requirements.txt /${BASE_REPO_DIR}/

RUN python3 -m pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org -r requirements.txt

# Copy application code to base dir
ADD ./ /${BASE_REPO_DIR}/

# Remove unwanted and env data
RUN rm -rf media .git .idea && mkdir media 

RUN  mkdir -p /var/www/static

RUN mkdir -p /var/log/server
# Set up UWSGI configuration
RUN mkdir -p /etc/uwsgi/sites

RUN mkdir /etc/uwsgi/vassals

RUN ln -s /${BASE_REPO_DIR}/vision.ini /etc/uwsgi/vassals/

# Setup Niginx conf
RUN mv -f /${BASE_REPO_DIR}/nginx/default /etc/nginx/sites-available/

RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Change to executeable mode
RUN chmod a+x /${BASE_REPO_DIR}/start.sh


# Change to Read/Write Permission
RUN chmod 777 -R /${BASE_REPO_DIR}

# Set env vairable for lang pack
ENV LC_ALL=en_US.UTF-8

# Expose port
EXPOSE 8080

HEALTHCHECK CMD pgrep -f nginx || exit 1

CMD ["./start.sh"]
