from django.shortcuts import render
from django.views import View
import os


class Main(View):

    def get(self, request):
        date = ''
        temp = os.path.dirname(os.path.abspath(__file__))
        with open(temp + '/deploy_date.txt') as file:
            for row in file:
                date = row
        return render(request, 'index.html', {'date': date})




