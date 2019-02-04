from django.shortcuts import render
from django.views import View
from django.conf import settings


class Main(View):

    def get(self, request):
        date = ''
        with open(settings.MEDIA_ROOT + '/deploy_date.txt', 'r') as file:
            for row in file:
                date = row
        return render(request, 'index.html', {'date': date})




