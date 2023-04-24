from django.contrib.auth.models import User
from api.serializers import RegisterSerializer
from rest_framework import generics


class RegisterView(generics.CreateAPIView):
    queryset = User.objects.all()
    serializer_class = RegisterSerializer
