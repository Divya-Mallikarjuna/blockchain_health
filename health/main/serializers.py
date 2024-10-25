from rest_framework import serializers

# Serializer for Patient structure
class PatientSerializer(serializers.Serializer):
    patient_id = serializers.CharField(max_length=100)
    insurance_policy = serializers.CharField(max_length=100)
    insurance_company = serializers.CharField(max_length=100)
    balance = serializers.IntegerField()

# Serializer for InsurancePolicy structure
class InsurancePolicySerializer(serializers.Serializer):
    policy_id = serializers.CharField(max_length=100)
    company_name = serializers.CharField(max_length=100)
    coverage = serializers.IntegerField()  # Total coverage amount
    deductible = serializers.IntegerField()  # Deductible amount

# Serializer for InsuranceCompany structure
class InsuranceCompanySerializer(serializers.Serializer):
    name = serializers.CharField(max_length=100)
