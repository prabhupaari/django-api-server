# Backend project

1. Use this project as template for creating Backend API services.

2. You can get basic login, Registration, forgot password functionality with Django and rest framework

3. It support JWT token based auth all api calls

4. Provide Docker configuration for setup this project

## How to setup in Local?

1. `git clone repo`
2. `python3 -m venv venv` Create Virtualenviroment
3. `pip install -r requirements.txt`
4. `cd server`
5. `python manage.py migrate`
6. `python manage.py createsuperuser` - Create ADMIN user
7. `python manage.py runserver 0:8000` - Run app server


## How to setup in Docker

1. RUN `docker build -t server .`
2. RUN `docker-compose up -d`

## API ENDPOINTS

 Login API (JWT)
 ---------------
   
   POST - `/api/v1/login/`

   Param - `{"username":"admin", "password":"password"}`

   Response `{ "refresh": "Refresh Token", "access": "Access token"}`

Register API
------------

    POST - `/api/v1/register/`

    Param - `{"username":"admin", "password":"password", "confirm_password":"password", "first_name":"Prabhu", "last_name":"R", "email":"test@gmail.com"}`

