from django.shortcuts import render
from django.http import HttpResponse
from rest_framework.views import APIView
from rest_framework.response import Response
from .serializers import PatientSerializer
from web3 import Web3

class AddPatientView(APIView):
    def post(self, request):
        serializer = PatientSerializer(data=request.data)
        if serializer.is_valid():
            web3 = Web3(Web3.HTTPProvider("http://localhost:8545"))
            # Interact with Ethereum smart contract here
            return Response({"message": "Patient added successfully"}, status=201)
        return Response(serializer.errors, status=400)
